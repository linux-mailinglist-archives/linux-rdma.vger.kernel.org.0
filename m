Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7D364793
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhDSP6O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 11:58:14 -0400
Received: from mail-dm3nam07on2078.outbound.protection.outlook.com ([40.107.95.78]:43745
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239800AbhDSP6O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 11:58:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBLQilBDIB1krjFD3ehWotYUMWKxeAeihdRnKPYKQNb9KCORIWpxkp7pkt6SNznsDrpd1pEdVaGpJKN46+LmeAcjdVS76sgNn2/nkiFpQZ+jMPyirDt4UqsFZD9ulRIRP6I4+6RN9DW0YbwuZnMirkKhy+49kf4689+iRAvDLL2Qm+xnNHD6LxmVineSzPrb4oA2cULWPUETbK28StMoNwT6mq6OhxsJTeK3cL+t6pgR6r8RaeqNqiYyvybuIvhtM4Pn6FKDBuG7L7kbGhKnGCeV+LBhssqzaNq/qgVZMEGc1e7pChQoSG2s/0xvNqn1aPM4mqYuUoklY2lirFVMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9wlo6MnGo/YAF67ldA7RbPEXXxQchc+yTzwa/qBKag=;
 b=bJrfGJPBZYvYUcU+LhHbad9m0lhmbApJPAd3lko8xci1PqgMAcPwDkf0JCb82P5wryxE/HmXp+a3xyH4EZnlF14w7JYOi03HoRrZDxwOhqBb49xInfHDW469YLRBKDctoYjgpwv4EG5ziloHB5JZvhTHDBByBRm+hH06Zm8ojTkgdxY3gL3+ilLnVXFzEXbB8+V/JQgg05bw2yrak0WcLu091VqvhzyN0N2BE6bCoGnlfsXQp8EBCyUZOPSPWys0scJYAHbJypkxaX4cnMA1rfHrO9nR4akwXjGSnlx2H7ETj20o2clAMdjbv8Kn2W3Nnc/MnpVnVADu8RhySZoslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9wlo6MnGo/YAF67ldA7RbPEXXxQchc+yTzwa/qBKag=;
 b=RdjzocftqEmZPvESXysrrYrZQWSxTBwrN4REuJAXjDQNdy04T9HVH5I6BjfKZ5JN7BGO6FklclLobB4kedfB+thHph/Oz6RKG/fEf19OgzJOkjw4/yJ99lp9xhl0h4A20GzHi51g0wJk6X8/TNpaPnAqDy10hmDu7h3qw2pJOmMmgZh9NSLsc9Cf4KZp7yrZz67qmCch6d5xmy2uN1fyfPRAYOkjklX9oLAfhbTu1PQ90JaKmMCbcCKiyyN5nfsik73Q0PcUJj4eoIjvncfR5Oh69d6UzNkYvvFqkyDBP26QOocgRohl9WzCk0bp924awz9d6cgjXIm+XGKMoYypdg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 15:57:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:57:43 +0000
Date:   Mon, 19 Apr 2021 12:57:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Message-ID: <20210419155741.GV1370958@nvidia.com>
References: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
 <20210408122518.GA645599@nvidia.com>
 <0E0C2ED4-DA48-49AE-AAF6-686B372638F7@oracle.com>
 <DE7C3C55-BDFC-47EE-ABBD-F2399697CBF5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE7C3C55-BDFC-47EE-ABBD-F2399697CBF5@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0005.prod.exchangelabs.com
 (2603:10b6:207:18::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 15:57:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYWHN-008TDX-J2; Mon, 19 Apr 2021 12:57:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dedc8d0f-2faa-4ef8-3842-08d9034bde0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737A92C2EDFEEA66B04DBD3C2499@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFnLON/6zbiEKK8zdRorpxlJUYX4EM2Kcve22TxHcrTB6kc3fiFKd1Ke6O/L/ozkEslBg6fqGkL8ZWqpshR8xiRe1Yc2RNJRKShKJJHUN7dFO8iT96yr5KmeREy3RzBhmpVz37cKccFLLXMExUP2iROs203HgZanFz48DNfU5/Hkuu5BEKpWEEOZyOmePomD92u000Qi8vsnu17zYLN2+cBOyk3um/ym9QjwlIVJ2m4XRHAYUlb4CAiEc3xgIj1bj1A1eOkkKSUbMBSB4zgKHJjIyvAg/MHVctV7QY9PsLFfrsDvRBOx596r+HdGoyKTG/NM2pHZKGgUc3mkNrHXg7i0RaKHsVKkQduoj+JxSssVdlD+ofLN+Lbt9tILLsrg4lOsIpk30A3IluujD+bNgVJ+X58jSPcnmhztuatC1pNRzxiJz6QIaS0b/VEjURE9wbSfo63tU8okzadCRlahtqGb4LAneA6PkVmGQwFmPU6TTbjiS4znsV32f1tSG+Vn/tuVcVSBX+9il1Cl2yq7ArkLQ82heCtiSrybT/Mk3obA+IaDiXDYxBzVC0bE8RmMZ/uTJfIukOluwSkSaWRxZGcBuStwvhB9ctjWs0N8pPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(2616005)(316002)(9786002)(6916009)(54906003)(1076003)(426003)(33656002)(9746002)(53546011)(38100700002)(5660300002)(2906002)(36756003)(86362001)(66574015)(26005)(4326008)(8936002)(83380400001)(478600001)(8676002)(66946007)(186003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eU5YUndnSVhPRnd3aGhyY1VyenpPUHRZcTBDaGJPV0hjVll2MTFmOWU4NWNM?=
 =?utf-8?B?ckVBSUx6djhjTjQ2OFVYUFBnSFozZ2dxS1pkaVdKbmUwWVh6N2E5MVlGSUJm?=
 =?utf-8?B?RzduQUJuaWN3UUZ2V2FORUVjZDdhc0JwMzZ2Q3FPVEdia0l4Wi9hMjJDdVpo?=
 =?utf-8?B?VE9VREJBbC9ScG5tV1FiYVRkU3B2ZGNaRi9QTTFwMDFnazJVaDJjTVI4NzZk?=
 =?utf-8?B?NXlxeCtZYTgvTzFRWTlBclhkLzdmT0YvclN4M0taUGNNRXdMWW1TR00weXZR?=
 =?utf-8?B?OUpjMzRuakZrZDNKMnkxcVVwUVVINVczOXJiTTlTUFlXWllVRzdxcDRld0lQ?=
 =?utf-8?B?bHl3ajVrRnl3c2FjVHljd3JCaWlGM1BaeGdURHJkZ0FGcnFGbFlva2NEZ2kr?=
 =?utf-8?B?SWtLbXk4QzdrcCtuM2dmbXVQVWtXcUJhVm5ocDhFSk95MWRtSkNyRnBwbFNj?=
 =?utf-8?B?YXlFTklQOG4vQ0o1OGN3MEVlRjYwUUJyTExaTzVXTnRyQzM0cm54Nk5ZRFZR?=
 =?utf-8?B?N0hla0Zha1JIMkw5T1RmTHczakpGeFRkd3gvU2lmQ1Q5azk4ZWduMmhZQ3dy?=
 =?utf-8?B?RDUyK0FGNEFsUjhNZDJJNE1IVDNuT2Q4SGM0SHBrYjFOUnBmVlF0MW4ydnRu?=
 =?utf-8?B?M0ZRZFpuTFdYcnRnd0llRVRwZzAveHJyNW8vUzVuY1pVTFoveGNBY3VwRTBL?=
 =?utf-8?B?RHNyRFlTdHdubWxVUnVyOVM0TmZTUmlrYURxYWZSWnQyV0xPYjZZOEd6aVRz?=
 =?utf-8?B?MXRIUlMzNnRnTk1kNnMxQ2xBRFNKUzVvd3ZBaHppOXdsc1Y4amdHQkE1YWI4?=
 =?utf-8?B?S2ozdzRXZ0s2bDg2VU0zMGIzL0tjeE1HNEJsS3pxaURZaVdPK0RMVmovOVdw?=
 =?utf-8?B?OHBLcUFOWDJxRlpSV1ZDcGJyeUx3Mjk3TitlcUJXRUJvK2tkZ0sxclNsMlZn?=
 =?utf-8?B?YnNYVkFRbVVVdUYyNHFVWEtQZkpWQ0tuSGtzRDlwaG5nMmh6akUzWXphRjFS?=
 =?utf-8?B?eWx5dlI0V3pDejRQcVQ5REZOUFNGMjJVKy9JWkpuSmY0RXJPdjZpejNCS0Z4?=
 =?utf-8?B?bnp5L3FVMUJ1U3FiU3VLM3lRbnU5OC9GaGlpQnB4bno2TlY2Q1kzUVVaRjU0?=
 =?utf-8?B?ZFg1Y0QzdHlWbnk4N21nQ1BrZzVhdjU5ZDVxVEVDaktybGhHUi9adGI1c29i?=
 =?utf-8?B?dGxZRXdneUpKZ21BeGw1eFROcGYwbDRiVi9ud2hURDVna0lUYWFRL3dZV0g0?=
 =?utf-8?B?cWlRSG9pa3VRNFZYeWRoOW9Zd2dCNThTVGdFam5FOGIvcnJqOU43YVljaDJR?=
 =?utf-8?B?UXNKUWVTZnBvYzhHUHF2S2l3TTNPWDNIRXRSbnNmVThrODhhMFUwZ2hIaUNm?=
 =?utf-8?B?TC9nSVpDNStQeXM2NFFQVHI3TWN5SDJEeVBjK2Z4QnhoZTZ5OEdvRytYZ00r?=
 =?utf-8?B?d092VXJSVjlWTFlEWm0wZ00rUTlXSHlRWUxnK1pwbTl2M250eEVzdHNwc0M2?=
 =?utf-8?B?VVB0ZzZJdUFGRExndnYxTE9VVXAyZTFtcC8zZitTQzRYTDlTSENRalgraDE0?=
 =?utf-8?B?NDlxWGQyckc2bXYxM09LeW9HQVNNRFBCSit3aVhiTWpIM2hES011dlJtSlNn?=
 =?utf-8?B?M3FRaHVPTmtJOTlPK3hsRmJDd2R1L2UxcHpKOTlub1RYYkVwN3NsUTZReFU2?=
 =?utf-8?B?dkYzdWdpR3M5U3d3TllzVU5Sejk0K2E5UGdYUnFOSGgvZXZUcGJuMEVNVEFL?=
 =?utf-8?B?alpCaDNURExiVmJIbm02STh2RHBpTnlYSThFaW9FM2NEaGkwNTBnOUprSG5R?=
 =?utf-8?B?UG5LV0o5RHNiaUZvVFpxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc8d0f-2faa-4ef8-3842-08d9034bde0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 15:57:43.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nby7BcKAFPto0P1XfNmzR3TKm6KqhdBXKyrxz6JfyVvN5s2tCJ4G+HSA84chSBIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 03:49:08PM +0000, Haakon Bugge wrote:
> >> On 8 Apr 2021, at 14:25, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >> 
> >> On Tue, Apr 06, 2021 at 12:37:03PM +0200, Håkon Bugge wrote:
> >>> In cm_req_handler(), unify the check for RoCE and re-factor to avoid
> >>> one test.
> >>> 
> >>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >>> Fixes: 8f9748602491 ("IB/cm: Reduce dependency on gid attribute ndev check")
> >>> Fixes: 194f64a3cad3 ("RDMA/core: Fix corrupted SL on passive side")
> >>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >>> drivers/infiniband/core/cm.c | 8 ++------
> >>> 1 file changed, 2 insertions(+), 6 deletions(-)
> >>> 
> >>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> >>> index 32c836b..074faff 100644
> >>> +++ b/drivers/infiniband/core/cm.c
> >>> @@ -2138,21 +2138,17 @@ static int cm_req_handler(struct cm_work *work)
> >>> 		goto destroy;
> >>> 	}
> >>> 
> >>> -	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
> >>> -		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> >>> -
> >>> 	memset(&work->path[0], 0, sizeof(work->path[0]));
> >>> 	if (cm_req_has_alt_path(req_msg))
> >>> 		memset(&work->path[1], 0, sizeof(work->path[1]));
> >>> 	grh = rdma_ah_read_grh(&cm_id_priv->av.ah_attr);
> >>> 	gid_attr = grh->sgid_attr;
> >>> 
> >>> -	if (gid_attr &&
> >>> -	    rdma_protocol_roce(work->port->cm_dev->ib_device,
> >>> -			       work->port->port_num)) {
> >>> +	if (gid_attr && cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE) {
> >> 
> >> I think your other note was right, the gid_attr cannot be NULL when in
> >> ROCE mode, so we can delete the 'gid_attr &&' term too
> > 
> > Shall I send a v2 or do you fix it when you merge?
> 
> Have you made up you mind here :-)

Well, I marked it as changes-requested so I guess I did..

But anyway I'll fix it up, it does look obviously correct

Applied to for-next

Jason
