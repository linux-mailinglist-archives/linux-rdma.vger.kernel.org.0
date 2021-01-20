Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1292FD3D6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbhATPUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 10:20:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17886 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390974AbhATPUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 10:20:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600849ff0000>; Wed, 20 Jan 2021 07:19:27 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 15:19:26 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 15:19:24 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 15:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjKvkzaSvQZtlewFdHy7znFPfKa7LMxIpAEwQbShT/OszQxFenXrhbC43AeFNB5B8N+JkwRh/IACdWrmsiD4rDDLhIo7TuhU/N6YJYr0ZsQPOrp4jqS8m57wus6NkYwNtmgfulIDmz5e4/jJnJBVzJ+mUBKXbd+pKv7ciHmt8os6L8bajTRuwa6KrJ+TZi6rMnVca8dEjdJWkj9VdRkX8x80e+7LMXDGhkH0Mhbwlb6CYUGT7DVQBGbebom3mULaBxrz2xr+Fld173pf5+FiEHYYc7pvMpAaSufPK4rDHeq7/PTEwoZbT3xKFcl/n2sQRBTtqQWnWRVv34OyNT17JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIh3oc8prU/XlJS5wsCLcj3mSmxlsWAcN9YLrJh4uyM=;
 b=Ow7C7RagWH4KrJ7TxxyqsvamLbP37WeaC/1WRP7Di6xOzJpI5oFfEG2nF9UJDM+GP4N0p+b0lxIGD03w2Zp2T12bCaKHizMeImN6TacRPBG4+Y64mqlZwaz47YNfpGC5aTUw3Aou9R2i1ADhVSrHuyMqKvpcf79hdtGibhMwnEcpPavENV5cZJ7nlcBqdu/b0OGsrbV5NeBIfBBMpIlhPQAdBFCVLn+fxWV7Mx25iPX2ySOC8DcVcZF4fS8Ah/r+gzgJB/AfrkQ21HWi+CIAEF1WZ1sJen6+ISsjXA0826fWuMiLUpVGhRjzxYPziy15zxiJmrDsz8iOm1rhBEse9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Wed, 20 Jan
 2021 15:19:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 15:19:22 +0000
Date:   Wed, 20 Jan 2021 11:19:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Martin Wilck <mwilck@suse.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Mohammad Heib" <goody698@gmail.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Message-ID: <20210120151920.GT4147@nvidia.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
 <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
 <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
 <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 15:19:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2FGS-004YOU-Fe; Wed, 20 Jan 2021 11:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611155967; bh=ZVTBuq0iXI0sRcM/EOvtkhQPc4IALbHQVH2dHAgGamE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NBj922+ytrAeUksGwgxeh+rQ7wlEbfe9YHzOEjmmDvCBlIpNNXvYS/hr1VgJuAKIN
         su0w080ejMe1/Hfc+DdNJpApbXnNBAjp99rg8NXN1KidXddWEgHCnlcBIlUcTfMfdB
         C2dyrqh+HO7f1iyeco7+98uQHMh+BOChwrngkOEuXlFj54MHPLOoCJUiFbpRjFqtAI
         m5YixFCIz4gi3Q9Ky4mkbpXvqZTT0QEeCl/xUSIu2/j1Y0HzOzd5l5mVb4+1/dvPT2
         0NnYu4VGvowULfXGcGBV/NOvbpFo5JEMs5EfSOSUsThHg7kPNNhuqHe0jvTDPKe7O8
         ZshURXgbcfhFg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 04:04:44PM +0100, Martin Wilck wrote:
> Anyway, Jason seems to agree with you that the way it worked until
> 5.10, which was fine as far as I could tell, was wrong. I'd still
> appreciate some hints explaining what exactly was wrong with the old
> code, and how you guys reckon it should work instead. In particular
> considering Mohammad's statement I quoted further down.=C2=A0Was Mohammad
> wrong?

In RDMA vlan support revolves around the gid_attr

To have vlan support the device must copy the vlan from the gid_attrs
associated with every tx packet, and match the gid_attr table on every
rx, including the vlan.

For instance, rxe never calls rdma_read_gid_l2_fields to get the
gid_attr for tx, so it doesn't support vlan, at all.

> What I got so far didn't help me much. I'd especially like to
> understand how you think the high-level user experience should be.=20

A single rxe device created on the physical netdev. The core code gid
table stuff should import vlan entries of upper vlan net devices and
the general machinery should select those gid table entries when a
vlan is required.

rxe should not be creatable on upper vlan net devices to emulate how
real HW works.

If your use case that work was creating a rxe on a upper vlan device
and relying on the tx of vlan layer to stuff the vlan, then the
problem is how the core code manages the gid table.

Since VLAN is not supported at all in rxe, in that situation the core
code should be filling gid_attrs from the upper vlan netdev only, and
those gid_attrs should have vlan_id set to 0xFFFF.

Then the ib_init_ah_attr_from_wc() will properly match gid table
entries for incoming packets.

There may be other things wrong with the core code because it was
never tested on this situation..

Jason
