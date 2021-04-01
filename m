Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4146351865
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhDARpr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhDARkw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 13:40:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07656C0F26E7
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 08:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI/3UoMRTt8Bag4Y9I/3KLOQB88zqEZW89FvryPUZ0uKVBVp/aFzDLS6ibtsar88WxZ15iNFwuZmsXP3vTgX4RKG5lwfNQGjYQGWNkyXrA3zunWzGT37X9nQ8ujBaMWRHwDF5vlFRDuQc9CPb9DI81whqEZ0V1DREjU87D1aEKyzX49Om8D6f+lKmSo+2iPwJb3Rzl2Q259xiF4at9Y5lvmpYMkazhZ0eZrOnycqCig2hdJhhTFRv9CJllaC63rm+G/U6cLxpLCjNSw77yCTHFjY+8dgj7EYMp8yl94o96wxoGXWnHYZUmYojDVW7wvBLNI9+v24jLjy7YQcvWoVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXH3z3Cjg84ojIBcYPFYxI7uIZwX7aXfDmNrVG9uuLM=;
 b=OZHIN3JgrYbmagS55rhEl92AQvcT8poFLz44ZKxsQVvfUdDD96KtTZiwu4djPu5c+qs14kxNWITqEO5AtRAewd4Vll0+23TUOMIsc+Fg5FWHxwv7ArjHXfwvgvajdiUnXxkhBGAJvJK+p9iV4G1ssd2oQl+lS1NXmRlkPjz2yFlSR/wTS++GFhZAO+BXiG2ZA3CJiEf3Vly1yV3jTMJlKFT8PdNYi4L7jAzWyi162NdBfTjgtcsVipkNh13sv890dMNmEo1MCa+Z+2VPjeCLb/eSFEwXO2nxLSTK6CF6MGfXyefAY1AQ8tUR+50zWaR5bNCWfnZorDTiZzudMbTaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXH3z3Cjg84ojIBcYPFYxI7uIZwX7aXfDmNrVG9uuLM=;
 b=PW18iTgqM2u66dWbw7K38PnoHnO/EvdPLLif8jUdfIyESLE0iLCnSol4utLs9/ZoGYxmcvC4hwdP5j0+q0qnRdtR+QCQhh9Q/8YLL2bNxQZ2abh3ES7F2WENsAQZWOqLzM0WRA58nQWXXyZbRR5wC3kHNfGmLNnREuY3GbHlPca2D0IsXhpFE/Qs2IVA2CnLZXiFvmTMTNYrXhDDVdnIporKQFUM8pGsbWLseF/w8m+2d/MRdhQbVI/LhVYGbn5hBbznjlV9NPA1MsTgBJsrdDoSrbVynLMDU7IHJeC125FbeYg+DgzIcOFRV7GKV9ek40/hNBS8U56YkmKd5oZh2Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 15:04:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 15:04:26 +0000
Date:   Thu, 1 Apr 2021 12:04:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Message-ID: <20210401150423.GH1463678@nvidia.com>
References: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
 <20210323194608.GO2356281@nvidia.com>
 <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 15:04:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRyrv-006mHA-Qa; Thu, 01 Apr 2021 12:04:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5a2633-e3b3-4816-0ea0-08d8f51f70ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49441AFD82CDD3A1AED3A7E3C27B9@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Hb2Kvxx9P9XOC0TFfpaEEvsTyLD8UQK7o/5BHonmDdvp5zVaptcorKmUNZcoXzzl17uvNZdxDeHNIiNTnLyTDXT0VBLBauBmQNUw/UtdMQiL8GbGF3lRwpU/iN+wGrEJ8uwuU06EzFA4rtu6d/tk8qW44Hf7qj+43Rmi6LJ3Kq38P2XRqMmV95ZVKGt4HyhylGBzRtNjeYbwmOXKOZvxi5bHLony90lmWX7ujbmKZKU1Y/783Jji/7P/9J2Z0PMM1CgWZEv4CPgrhNOKkjocVMbezhWUQkS9RzK+1BYzCmfqolFTn+L7WheySeSXtZZAb2Nq8MPoGTEr7vqGiQ+iCr9Joc87tB5GBjcrYVlMZXwxOpvaG03YJpbOp2N73udEiV3cmf4G7rFUvcYbA4DM+WZjZGCPItqApk5cY6N/iJVcfbF/NRiIYAfzw4wPpqPZGzjS0xlL4a4ABbACA5rPx/YfhQct7IByu3f1SyqDDR1+T2ZsU7J1TpktS7QmwSKZmqLTNyf2cuwmLSoGZluZxOsGg5U8IJCoksp5zCik8XI/qgyt9mmDHdehwRZHhcHwlkfShF1YJVc+/lGwQ6bwJQC/2Ku9Z+E64MEmVjXx7ST3ipfpTbuTXJ3ZPIJDICfZMLLUFgOHcYewbn3gs+q30YikYSSDECdv7YBV98OimU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(8936002)(36756003)(186003)(83380400001)(4326008)(6916009)(54906003)(478600001)(2616005)(66946007)(426003)(26005)(53546011)(1076003)(66574015)(9786002)(2906002)(316002)(86362001)(5660300002)(38100700001)(33656002)(9746002)(8676002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGJCOEZMVFFVaVZkTGxmU24vK3o3eFRHcE1mdkZLTWMwN1BjSU5ERVNya2th?=
 =?utf-8?B?NW9aOWkxb3RVdjJJdzJSYmxYdUhIVXoyNnZSYWxHdTRDcVdsUlJrL0tpemJv?=
 =?utf-8?B?aCtyZTQ2R0psSU1OZHlqbFRlQmYxMmRyYXI2T3l3dXNPSTFTaG13QXUrMUt2?=
 =?utf-8?B?OU9wNmZnZ3FzNzBDT0FmU3RKTDNMcjhOUDlnQlFYcWZNSDZrVkhud254b1dp?=
 =?utf-8?B?NlFrQWhvYkNsREtsYVVpZHRSaXp2cllWZm12R0hIV1YvTkZHMTFWNSs5MHFO?=
 =?utf-8?B?NXA4M0RlZ2cxTVJiYjltZU4rMjZzUS9YcG9kVk51MGI1SE5mUHQxVkhXQTFX?=
 =?utf-8?B?amhSM28vRXZDMHZ5ZUEvUVRMc0k3c3ZZcEFrenErd2xhYzRZcWg0ZDJaOUpw?=
 =?utf-8?B?MFVzaGxRcjJpSUh1Z0h2d3NGV2xaRlE2RjZQS3pPUzZZNmlacElZS0dLNVVH?=
 =?utf-8?B?cUVKRXV5cjNxQXVLQkFHTFNYZi9LQVZrdUFDb1M5VmRPeGxreUlrKzFQNUx3?=
 =?utf-8?B?bXNzSGIrRklOVmZ0Ty9ndEQ4K3NRc0lqM3dOS013MXRuMTFUekNLOVd0WjdK?=
 =?utf-8?B?OUlOTndOMHV1ZUpqZzgzV3JvNzB0WEVFRFZMZzFhV1Z5emZLYmdEZ2NrdDQz?=
 =?utf-8?B?WTYvOWVPYU1PRHNsczFncm5OWko5UHRsa1FPZnNPWWc4bTFQQlZGNXd3dnRh?=
 =?utf-8?B?dTY5aVJHNkNueWc0YmE0bHQwUXJBOFN2Nm9XSjRTcjA3K0dqZ3JmUzZVV3ZV?=
 =?utf-8?B?MlZPNGRPZXVtNmJSYkdtV0thUzdxZDF3Y2tOVGVncmJJb3c0eVBwM3RLOFlj?=
 =?utf-8?B?NnVBUisyYmlWQ2NqQjNSZmpuK3JyMHBxT2Q3SXQ1TVF3QS9PT0NuRmtvRHFP?=
 =?utf-8?B?bVIwUmVRM3lWRGxycDBKVmYwczlUTHdrMkhHT1QremM1QjhRSDFYazNmZTc1?=
 =?utf-8?B?a2g0TVBTVEF1Tk42bkVYdWVFQmwza3h3VCtpL2tDb29MSFNoWVNHUENtWjJk?=
 =?utf-8?B?cXJFMWhHM0hjVG5EWW4wUk9NeVRhTjduYWV3ZkhMbzJXd21xc0FXcWFtOGZ2?=
 =?utf-8?B?dS94Y3RkVEF2Y2tWQnV0RGFsVkRFaktOc2oxaXByNkl3aHhka2NZTGhsdWE3?=
 =?utf-8?B?VEFDeHM0cEdlZHpEL0o0RG8rM2FZbDRkNmlqOVZIbUd1czUxZktXbUlYQ0F0?=
 =?utf-8?B?MjdrUEZlRkZxajVRendQUEtEOGl2Y3lxemlEYlU4bGZIS1VVRW1TT3VMOE5v?=
 =?utf-8?B?SE5Vb2lVOUI0N2xNMFFwNnArWXUvdkF3UVp0WTN0blNzQ0lWazNIdGhubGxS?=
 =?utf-8?B?eURrNU5IMzJBazc4MWQ0cHd1TjlSc2h6aE9TaEpLRnlZYkxpWjVKYzZMTlpj?=
 =?utf-8?B?dUxEcXlzVDVJZTJndExTS2N1MmRwL0ZZK0YvUlNUZ2JBWHlIU2hWbGg1TEhN?=
 =?utf-8?B?bEJmK3FabkZacitLMkFReXA5b0JSdXhSbE0wT3J2UEdFcHJqdzVaYWgxR2Fz?=
 =?utf-8?B?WnVMc1JwQjMzTFNUcDhXb2wwcHNaN1R0YXFnMENrVmZYMzdzQ1pOVk5Qb1k2?=
 =?utf-8?B?enNic2lXZDZDUjMwcUx3bGlMU1BTSkdsbkgvQURrUXBwcjg3YU16K0FlK3Z3?=
 =?utf-8?B?ZGNmQjVKeFdscWE3Wit6amFKQU5HQ2pNSEZmK2tOcEN5QllSUk1wZjdvRnQ4?=
 =?utf-8?B?ZE16RnF5WHlrN3BJQUdNMlFoeDNvNXRNYmhZd1loN1N0Wk4wNHNiaEYvRmNG?=
 =?utf-8?B?MkJLU2RocEY2b0RFVTRJWUxSc0lmazNiK0d3RWcvS1RIUnlVY1loOEFpQWs0?=
 =?utf-8?B?ay9SV2ExZVp0RHE4WFlvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a2633-e3b3-4816-0ea0-08d8f51f70ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 15:04:26.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bqzMtjSrVm5mRtTPoWpecll2rrmycncfPbRzy9Q7PDq9rVuJFwJYLNcVwIG/L6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 02:34:13PM +0000, Håkon Bugge wrote:
> 
> 
> > On 23 Mar 2021, at 20:46, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Mar 22, 2021 at 02:35:32PM +0100, Håkon Bugge wrote:
> >> On RoCE systems, a CM REQ contains a Primary Hop Limit > 1 and Primary
> >> Subnet Local is zero.
> >> 
> >> In cm_req_handler(), the cm_process_routed_req() function is
> >> called. Since the Primary Subnet Local value is zero in the request,
> >> and since this is RoCE (Primary Local LID is permissive), the
> >> following statement will be executed:
> >> 
> >>      IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
> >> 
> >> This corrupts SL in req_msg if it was different from zero. In other
> >> words, a request to setup a connection using an SL != zero, will not
> >> be honored, and a connection using SL zero will be created instead.
> >> 
> >> Fixed by not calling cm_process_routed_req() on RoCE systems.
> >> 
> >> Fixes: 3971c9f6dbf2 ("IB/cm: Add interim support for routed paths")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> drivers/infiniband/core/cm.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> >> index 3d194bb..6adbaea 100644
> >> +++ b/drivers/infiniband/core/cm.c
> >> @@ -2138,7 +2138,8 @@ static int cm_req_handler(struct cm_work *work)
> >> 		goto destroy;
> >> 	}
> >> 
> >> -	cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> >> +	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
> >> +		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> > 
> > why use ah_attr.type when a few lines below we have:
> > 
> > 	if (gid_attr &&
> > 	    rdma_protocol_roce(work->port->cm_dev->ib_device,
> > 			       work->port->port_num)) {
> > 
> > ?
> > 
> > I suspect you can just move this into the else?
> 
> I can counter that by saying ah_attr.type is used ~10 lines further
> down in the conditional call to sa_path_set_dmac() ;-)

Hum, OK. Please send an additional patch to unify everything around
av.ah_attr.type

> > 	if (gid_attr &&
> > 	    rdma_protocol_roce(work->port->cm_dev->ib_device,
> > 			       work->port->port_num)) {
> 
> I cannot really see how gid_attr could be null. If
> ib_init_ah_attr_from_wc() succeeds, it is set after the call to
> cm_init_av_for_response() above. May be using ah_attr.type in this
> test instead, for uniformity and readability?

The GRH is optional, ib_init_ah_attr_from_wc() only sets it
conditionally.

Applied to for-next

Thanks,
Jason
