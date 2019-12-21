Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7F12865F
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2019 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLUBdD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 20:33:03 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1863 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLUBdD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 20:33:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd76440000>; Fri, 20 Dec 2019 17:32:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 17:33:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Dec 2019 17:33:02 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Dec
 2019 01:32:57 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 21 Dec 2019 01:32:57 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd76490003>; Fri, 20 Dec 2019 17:32:57 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Noa Osherovich <noaos@mellanox.com>,
        <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] pyverbs: fix speed_to_str(), to handle disabled links
Date:   Fri, 20 Dec 2019 17:32:56 -0800
Message-ID: <20191221013256.100409-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221013256.100409-1-jhubbard@nvidia.com>
References: <20191221013256.100409-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576891972; bh=15uHeEx+BUrKTkjhLcSO/RSQ9/iF69A3ke7v6PTPl/0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=O55iA6GbVAA+8QqdCczSozP6QKGtlN5eMJNskelsCsjvwVIhdr3/mjllIp+keQnDd
         zuTFYDHm15f5NBTfNV1d0LMLkYlCyARvEulpd2FsDE1BkhOSlWiVP3lNl3dq3WwT0j
         UcbyZZHRcagmt4/MI+xs53T6VbkLUIg5HoxwIiFiSbU8c0Nocm6+26VdSJdrNVboI1
         hnk/82TzgoQ1E+UiuT29kmVHBOndOtHMi0jp2eMy5yKfuzoNBur/6ajySFm4FSW446
         Vlip5P1miINTbFhrgX6p05pMfA8GDNv/gBN+zSmKmoLQ4DcRFs874KuGTfZ0yLSWq6
         6kYaN+FGEBGfw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For disabled links, the raw speed token is 0. However, speed_to_str()
doesn't have that in the list. This leads to an assertion when running
tests (test_query_port) when one link is down and other link(s) are up.

Fix this by returning '0.0 Gbps' for the zero speed case.

Cc: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 pyverbs/device.pyx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 33d133fd..cf7b75de 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -923,8 +923,8 @@ def width_to_str(width):
=20
=20
 def speed_to_str(speed):
-    l =3D {1: '2.5 Gbps', 2: '5.0 Gbps', 4: '5.0 Gbps', 8: '10.0 Gbps',
-         16: '14.0 Gbps', 32: '25.0 Gbps', 64: '50.0 Gbps'}
+    l =3D {0: '0.0 Gbps', 1: '2.5 Gbps', 2: '5.0 Gbps', 4: '5.0 Gbps',
+         8: '10.0 Gbps', 16: '14.0 Gbps', 32: '25.0 Gbps', 64: '50.0 Gbps'=
}
     try:
         return '{s} ({n})'.format(s=3Dl[speed], n=3Dspeed)
     except KeyError:
--=20
2.24.1

