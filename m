Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F662B5241
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgKPUQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:16:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2706 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgKPUQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:16:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2de170001>; Mon, 16 Nov 2020 12:16:23 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:16:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIJoOTqLuvQEPRgB6u9TLnnz8Kn8Eb1+Ooyh9SANei639H1ITmxEHv8fZujwdD/bX0ypUlte4kpM4ZRTVbVHpLfcE3crEto0qyPfhJwUrN3Te7uAiAoaJexdGzz1b5orKux3fUyHR+gNDYs6b3fp+TpMGHxW/r6VqZkQYhFE5atfepwF7ORR/UsI88fGQFjVW5WwVqi4vXxUOf95rPGeOoSDqfbd6pL6yxDQM5NcFFPeEKFGryOAyOV7Q9nqYePZT5n8USyrRPOfahmjwVF3gSjFdQZmPJBZ4ox6OQJNuRV9kwqXInSfCl85a64Yk9Yt604WLlYGyMviwcG0dq3lEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlbAdzOllc55KkeYRZN8ZzMzbXRYS4Vqs8NBNaH3xMU=;
 b=QFW935k7qYJM7wZNEkq9EvaI00YjNF7SH4eU2RGebTcQQVrF+lwGGZ2OxvnIcbgndDLkic+NOAEYj/DPFbYtG5wq6Fk4vgPvs9rBYJlQOeq8u319vbt1Xip8+vsneQHTFgN3FrHkSNPL0SCrMzvbSOrBAPHScnFOKTUzKSWj5hzlUi3UYNLw+i5FfXr4KieEiQBxLElGm8lS1n4Dsd2fzQYBEFjiWX2uoKOIafJoP1NL4w3gi4kZnBQSOWlBAqmvnnUAXxDZCQrPEyoQEkderTB2XwqAvYnZRMwURcJEFqxLxP8u8qOdQ8h/q0GBMjzO70mL14YwQoJvERrv1RFefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 20:16:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:16:18 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH 1/4] libibumad: Check for error returns in get_port()
Date:   Mon, 16 Nov 2020 16:16:13 -0400
Message-ID: <1-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
In-Reply-To: <0-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 20:16:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kekvA-006km7-LT     for linux-rdma@vger.kernel.org; Mon, 16 Nov 2020 16:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605557783; bh=Smo/E0Cg0JND1ms18JnvvPBN7uwHi/FjgYDnIVEL1p4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=D61dao9w7X2Mk+YGL7nzw2HRS30p+QE7y9QPIPuhaHtE7+LIvbzwkEvj6/wM/PMA+
         3e+iF2ZAAcrcu4IN0yi4ul6x8U9sJsvdNW1R/jWa97QpCfDe2UiuVax4O+4yG7IOen
         niQlnVn/vqOLoyUd0gRWgadomnexGOhvwjf6zN9VKMKaAeKi3YyBO9rsKj6xaxfU0d
         sVq8uDqUWG0CdDwV6izbMdAQpDZ5vEXKPAieaIOwIewazV8lvIYfmFNrV639u6x/Lx
         5S/DXTfAXCbup5XeA6JHDXD/r6zSRICDBRV00yVeDXVwQd/HGNU0dpMWt+z/GeaNuq
         +xNWIuyuWzsBg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Stronger control flow analysis on GCC 10 with LTO detects:

../libibumad/umad.c: In function 'get_port':
../libibumad/umad.c:208:20: error: 'val' may be used uninitialized in this =
function [-Werror=3Dmaybe-uninitialized]
  208 |   port->pkeys[idx] =3D val;

Caused by ignoring the return code from sys_read_uint()

Reorganize the goto unwind so it makes sense and check all the calls to
sys_read_uint().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibumad/umad.c | 49 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/libibumad/umad.c b/libibumad/umad.c
index 90b8c0ce409c2e..b23b345a4ca299 100644
--- a/libibumad/umad.c
+++ b/libibumad/umad.c
@@ -148,7 +148,7 @@ static int get_port(const char *ca_name, const char *di=
r, int portnum, umad_port
 {
 	char port_dir[256];
 	union umad_gid gid;
-	struct dirent **namelist =3D NULL;
+	struct dirent **namelist;
 	int i, len, num_pkeys =3D 0;
 	uint32_t capmask;
=20
@@ -158,23 +158,24 @@ static int get_port(const char *ca_name, const char *=
dir, int portnum, umad_port
=20
 	len =3D snprintf(port_dir, sizeof(port_dir), "%s/%d", dir, portnum);
 	if (len < 0 || len > sizeof(port_dir))
-		goto clean;
+		return -EIO;
=20
 	if (sys_read_uint(port_dir, SYS_PORT_LMC, &port->lmc) < 0)
-		goto clean;
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_SMLID, &port->sm_lid) < 0)
-		goto clean;
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_SMSL, &port->sm_sl) < 0)
-		goto clean;
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_LID, &port->base_lid) < 0)
-		goto clean;
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_STATE, &port->state) < 0)
-		goto clean;
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_PHY_STATE, &port->phys_state) < 0)
-		goto clean;
-	sys_read_uint(port_dir, SYS_PORT_RATE, &port->rate);
+		return -EIO;
+	if (sys_read_uint(port_dir, SYS_PORT_RATE, &port->rate) < 0)
+		return -EIO;
 	if (sys_read_uint(port_dir, SYS_PORT_CAPMASK, &capmask) < 0)
-		goto clean;
+		return -EIO;
=20
 	if (sys_read_string(port_dir, SYS_PORT_LINK_LAYER,
 	    port->link_layer, UMAD_CA_NAME_LEN) < 0)
@@ -184,7 +185,7 @@ static int get_port(const char *ca_name, const char *di=
r, int portnum, umad_port
 	port->capmask =3D htobe32(capmask);
=20
 	if (sys_read_gid(port_dir, SYS_PORT_GID, &gid) < 0)
-		goto clean;
+		return -EIO;
=20
 	port->gid_prefix =3D gid.global.subnet_prefix;
 	port->port_guid =3D gid.global.interface_id;
@@ -194,37 +195,37 @@ static int get_port(const char *ca_name, const char *=
dir, int portnum, umad_port
 	if (num_pkeys <=3D 0) {
 		IBWARN("no pkeys found for %s:%u (at dir %s)...",
 		       port->ca_name, port->portnum, port_dir);
-		goto clean;
+		return -EIO;
 	}
 	port->pkeys =3D calloc(num_pkeys, sizeof(port->pkeys[0]));
 	if (!port->pkeys) {
 		IBWARN("get_port: calloc failed: %s", strerror(errno));
-		goto clean;
+		goto clean_names;
 	}
 	for (i =3D 0; i < num_pkeys; i++) {
 		unsigned idx, val;
+
 		idx =3D strtoul(namelist[i]->d_name, NULL, 0);
-		sys_read_uint(port_dir, namelist[i]->d_name, &val);
+		if (sys_read_uint(port_dir, namelist[i]->d_name, &val) < 0)
+			goto clean_pkeys;
 		port->pkeys[idx] =3D val;
-		free(namelist[i]);
 	}
 	port->pkeys_size =3D num_pkeys;
+	for (i =3D 0; i < num_pkeys; i++)
+		free(namelist[i]);
 	free(namelist);
-	namelist =3D NULL;
 	port_dir[len] =3D '\0';
=20
 	/* FIXME: handle gids */
=20
 	return 0;
=20
-clean:
-	if (namelist) {
-		for (i =3D 0; i < num_pkeys; i++)
-			free(namelist[i]);
-		free(namelist);
-	}
-	if (port->pkeys)
-		free(port->pkeys);
+clean_pkeys:
+	free(port->pkeys);
+clean_names:
+	for (i =3D 0; i < num_pkeys; i++)
+		free(namelist[i]);
+	free(namelist);
 	return -EIO;
 }
=20
--=20
2.29.2

