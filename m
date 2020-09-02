Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A587525AA91
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBLwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 07:52:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:43501 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIBLwh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 07:52:37 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4f87830000>; Wed, 02 Sep 2020 19:52:35 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 04:52:35 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 02 Sep 2020 04:52:35 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 11:52:33 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 11:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8z2GJk12KaUddrpN/BK7KfVYhZBzPT+nUkeNLjX7eY+ehs0umln61nPTAZMT+f68G5V/xg/UQoV90ZdycPZzCL7k8PxupOfpWCXVLKGhWX5KqaqUax2UN2lOS3n1m2K/LPsS3NV3QlS9VEZ7OKMs3daAQou0bv66b2xjq6X/EYdmELQQmofB5AtCdbiniVgq3gHRyjiz01/oyPjgI7ic+rtuYw8dnZeHM/a9OOIfucWpxKar7VlAwrhzP6/3vFNK2z/45jTb2ZKx6WqpRecPCdyyqMRh6FP5CGly+YRJior0M+dF4uSZhkdX5oH5khBuyr5AXRHBVXsDxdqSwe5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huHJj8buu13lpfAw7HRd1Fr4BS70G5zpcblJ8WSNz/A=;
 b=fY17jL4u0fBnHxiOSkGYQfbeeL7ysvxUIvV59iqxISByt++HqO586gekXUS3hGqWx6MVYgsmHuYJ1M7Zu5WJVouvyJn936v8EiNRmNQ8En4WPSaiMEWlKjdPq3WNrEBYLyThqtHQjOW2rOYZa9/XPDLTmI8PrXSvPc1mrJCu6/Z3zPlN2fSRm2N1h8cIbRUnyBLoyw4jV4TwtQnoqTPEzlt2JvnI1BKeVXbkjkyQuUGlICM4SE3EUeDdD/XL50j3qjLH1VtIRsQvk1Hn8N4awillEdFzeV9/DZeEqUpo8QY7ootKSWFfcJbhoQCPlExhxeJIHwECKKwsHwOPwplvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 11:52:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 11:52:30 +0000
Date:   Wed, 2 Sep 2020 08:52:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
CC:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        <kbuild-all@lists.01.org>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg+lists@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [rdma:for-next 16/50] drivers/infiniband/hw/mlx4/cm.c:496:48:
 sparse: sparse: incorrect type in initializer (different address spaces)
Message-ID: <20200902115228.GP1152540@nvidia.com>
References: <202009021436.HsjhN4O1%lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202009021436.HsjhN4O1%lkp@intel.com>
X-ClientProxiedBy: BL0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:2d::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:208:2d::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Wed, 2 Sep 2020 11:52:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDRJU-005cNe-LS; Wed, 02 Sep 2020 08:52:28 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b66955-0038-47d7-5211-08d84f36aba7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203E4814B2E5879FA9D1B0DC22F0@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMR5iOve7t+jIbyP5RxH5Ji7pTHTw1iZXQ6Y1tTfHOgRHWh0xr6JBBpIPI3dfbWOMMToBvGuM3Mcat4diQ5DLwfU60HJjNWset0vHsXbhYqD7KbKNh6QMueUat41fjvAPHgGUArwP2twF520lr+MycjHcfh7OBjl8Ij1ziEd63NprfkhMg/bE4rHtWnItlVpPoUbLjtBSeigJzRTNXGZbsC0DhRqru43XiPKtf85vCmgNxDSEBuCgKA7tIL31Ov+jL/tmirBhKYxT/8UkAT9uLhRfEowelTk9ziB4/9FDX7eiWTljv6lGlt0rGB1piwVtXri32JN7YjauVYJgNIPC6dEMSryuQhfUfpciUPBG4//hGRbLR9wSwvvY/PKFNg9VMAHjySk1XChlEU3jMuc6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(33656002)(66556008)(8936002)(426003)(54906003)(2906002)(36756003)(26005)(5660300002)(86362001)(9786002)(2616005)(9746002)(6916009)(966005)(4744005)(186003)(4326008)(66476007)(66946007)(8676002)(478600001)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1ReCdV1g0ETdlDLIor2z7p4ILM0EusjCWiNUppfh+Urpb1Fz/6TfV8hplpZwV5aSUV8wZb7ex+Pl/qAzXRstOiVW19Razf0q/P/timMav4kId8v/QpxZY27NTi8U2yGjRTiXgqBuvR9KrQYrD7VA6qm7vNZBgTtqndVgEhJsEx9/j7zEmk9du3ZerAyVEpU3OY4TkSW/xUoszVI3kueAOAIryYMV7+bsb4GP5ha8j+dSOz6RK99ZD/UVhUKrl+yB9VOimMkonfAEcxH6SGn+ipxi4+ZbSzeopnvbS8H40fxLWT/Ee8ipBkJdwzRdAM8uddUeMkDu0BgZpw4iwHxqf/9C+CgAU4NyLcosCdqReAJoT3oEPENqbLV9TmfYE0HS/IXTr4qssRTuV47lUOn3sSOPaZ5aGYvQquQGA93cQa+esrBSgT87oEegGULwjYuXiHFN7ZTtHZlguBSvQAF8h4ClNwuu2uKKiiCJwkeMtk9rlTLeUvDNIEz/UjxpkN1MGoWQiqlgm0l8FsLpjpB+Vn5kG9vNcF9I6ZTioHJRW8hYMLz1yipPAiGOrQgGUbHhu/Lz/SOUB8X6STkBObRR7jrxl7iCWwTziiSjsZyRnAROZ7F1pDsPkZPL0bCUgzVgMgVWCeNGFdT6Ww/6c2Yrew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b66955-0038-47d7-5211-08d84f36aba7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 11:52:30.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqPI+s7w03CAV1QCoVsk0Xde/RxdSJnJKi7hlOCisCjAyoxSNDIe/0Q5ORK5o8u3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599047555; bh=87DfZVqwWi/udLGt1zP8jfOztWEre3Xl7KOUj8GNbrg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=hswBOACP/yTcBJ3NPZWhBlZUB5BHUOR+HNBZMsSCCTXzCBNmab6iVRJ/jTOL/tD4w
         8ySbCK55EvwEYDN1oEI+myrjkLDX1JvD7u7ONx/GJGlrtgtlcOYPtmo80FfguG36Ai
         AwwqG3I6B3nK98DBQMqKveVjIYnaON9NSZwjVjNDO6wuwM9SeHL8DZPHfw1Q3yzpk+
         0swFDcnEifknXTDhAHXCdt78lEh17G2EYDAEuFZzO+TPbHObuEM8eMWk2YLYrYXxFt
         Z7I3eDt40xKf23AnW1ON/9xlOpZ12Nv+Fyk4IM+0JrXjsOguz45EwN+KVq5IdJhCAh
         nB+kQfCc7rgqg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 02:01:41PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for=
-next
> head:   524d8ffd07f0ca10b24011487339f836ed859b32
> commit: 227a0e142e375909959a74b7782403e14331f6f3 [16/50] IB/mlx4: Add sup=
port for REJ due to timeout
> config: i386-randconfig-s001-20200902 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-191-g10164920-dirty
>         git checkout 227a0e142e375909959a74b7782403e14331f6f3
>         # save the attached .config to linux build tree
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' AR=
CH=3Di386=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Gah!

H=C3=A5kon, radix trees are not allowed please change this to xarray!

Thanks,
Jason
