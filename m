Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3D66E669
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAQSsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 13:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjAQSd3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 13:33:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB51D93A
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 10:05:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+GGeBpaqm72Godu+JMb9SY/AWH8KpIK0SAOXA2QnOgJ4fGKV8is+zmOLo+3lDyXOgfZPeK2Xs+qdqODkiItRRSw9lmfPSlbSyxZz/3DnuqJ7r2AmWL6tOcej3kP884vTinaj+BySzRdY50mRIsG/bmGkhi3jXhHH57QeuyuYMVUSvWNz1inhx9YC/zNMo7GcDwP0QaztTTMDkL5A7H4seGhKb8Z8KFB6lU7RTwbTW7JThtMC0J8V6OXnfAw/7oqsUynq7VOXiqTSyYgsD5uKnwKlZA4TOcwG+58jZsonuc3bNyL6/hJjSKeC8CKpDzvsvZepq+vdFxr/QF7k6iJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edmf+boYWAwGOt1BXfEPAEJDxo7EL4aPFXjflmMMfRE=;
 b=ZvdTNvpOztBNhp7YKJJFZDuNjhPHjqUGswgmhSmyreT9qM0css7zKYhApZVVJNUpq0UqAJEHnUsOIRmjCFkqnHll1APosPzwzz4oUBpNcGatK9E2rI0XTb9DMf6ap37aTa5zv6s31M6PfebhVd2vz2e/OyNjj2CsmHqiRN6YXB99kZgspkNtxeiWWUxSPtZWL7kI90BVyeO2tl7c2vV5TuWPNLDUxT3XPPGOduchBgVN1cjgVsUt4ceqULMgiPDxrZOJRqWMuCHL5RBjBKtTrEYTv+8nRBiYwrli/U6KLtE5h7ONy8/SlSmzbqrEh2Obia7faDb6Jbmfi4n2TZZqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edmf+boYWAwGOt1BXfEPAEJDxo7EL4aPFXjflmMMfRE=;
 b=GqXGV28JWJnTsv0AWMF1DW7W8IbNpslOCowhWSVccNWxzf5R+hyJJGXoseoeN5T/Bq2ccjo70ejIOLLbhIuK3VPRtYPuW3Gr9Wr/N6wWYKZITeJiPcbyy/yOR3vM+kLT3CBCBKDB6H/u6knT6s1F7GET4G5LstkWcp2VtnfWnC9IXbf0omf6sjX2JrbR7F9lm/yelhRIvt2NwHjKJHYkFqNNUXZisnclJJDdCFhRLZToLUA23fVTu8zXfFXhKBEVjvNjMhQOyyBbCvKjTHrHb9WG8r7QDNr/FqWAX3IsJxfVo9Dy9Wftp2I5A01YKzILdK7OgJ3vzMCrRNHmXdenow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 18:05:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 18:05:24 +0000
Date:   Tue, 17 Jan 2023 14:05:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8bjYnQLvw3Uv7CD@nvidia.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com>
 <Y8a6mILrIxIwq4/m@nvidia.com>
 <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
 <Y8bUAIsqMXvHIJNb@nvidia.com>
 <15174079-2a2c-c84f-3b37-7e0f26b553cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15174079-2a2c-c84f-3b37-7e0f26b553cc@gmail.com>
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe77633-4997-4787-fc02-08daf8b567a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by9vq7sxhmgTOSwLXKV9F1QnDAlv63XxsKqzYwPixKO+sN8bZoT+syl6H2ixc80qqFBDgXekSBWm0CPrvufx7PpVigmQpXhfQSWkWQTBZ/CkjjlJqWTmfhrd0jtcI1wwcTh88hUsJ4gkvtpWPCPVvuWY1keqiIQjrpu5XcXuYx93Gyi+iQQNfg5tfmf0ZzDKrezkYcLToDK3NACNlFIa/noaI8Q+q6i4qe5zM7A1R1Rbpi3o9A+LaWeoW7M0LCto+z6GfVpG0vtW3XRiJB0Ua9SHGww06l9rWbFS7jjmkTHphAEPrKQg+0QarpsAhoclNi6OTDj6hogQhkmKFlRiHutx6tJ5P4YP4AvHVDSM9BEtUuDc++veyxtJZR+XBSzZW3ZulWX7n/7sPoEbKr7PwmjFRnjIUJsapO017h1w1G4qIR8A9yhF32hNTcKq6CGzW2/E3FLBUCkkam4xJoErAdkWbN3iQjnOwuYfFX5zamcJNFkJOMlSQee5uvuLYAnbGYwxKvMw65T68eUFuZ9rtEv8YJxUJH8XPGjgE2iGEQR/aT8MyT6lWpSaeIWrua1vrIsqePvKk43iEO+QKJqOGljvcSWScZFVlJN8bg1xIniH7Q5de/jcjo/j3vP1LFNOE8V5kWL0fToEtzWjC8YhfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(26005)(6486002)(478600001)(41300700001)(6512007)(38100700002)(186003)(86362001)(316002)(2616005)(66476007)(66556008)(66946007)(4326008)(53546011)(5660300002)(36756003)(6506007)(2906002)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cj4G3Bat8TdguEwLit4g7IGWK+5ZfIq+AmCFNP7JQ3qvbi2gIGScg9+Jpm0T?=
 =?us-ascii?Q?TOY0Z+vf8DUu6kQG0U+2FbImlowmv/oF8ZWsSUPkyQ88WLgyDI2gnxvJZeRB?=
 =?us-ascii?Q?tdmtapjkcYwenYA2ahxk7Hgif1kWJS4GSjB8Lzq4fumikGmCT8qBSnVXDQmo?=
 =?us-ascii?Q?7ZNjaRqU9movV8FSwpHiCKuHYfHWrmeUlD5iSkRMaEXZr5ll1Mv/1cInjytI?=
 =?us-ascii?Q?tCxy0JTabcimwVYHMFJc+52DoObxD5yxRuGAXCnK3iebZ4FZF2Tvjn/ORTnn?=
 =?us-ascii?Q?Vxbjgnz9KgpKZ8l0n4YtBJWFQNvCNFHDw2Ku0LqwSDd8TpnhiL9Si86qo/fk?=
 =?us-ascii?Q?ElXq0Zc9etStOrt4Gnu2TanjSAAEGqE/XpkBov8VdV47oqfxC6u4Q8POGUOT?=
 =?us-ascii?Q?TdlDarjuXptsdm0kCPJpSOHAnMD0+iPE1tS3g3cWwbjW+uBq5uMqpTKmg+Wl?=
 =?us-ascii?Q?Jl1RRTyMaifgL7sfZbkfgOze8aN6HbQlqb+6pGniS3XYgEvUkjOm8qb/uA3Q?=
 =?us-ascii?Q?Qnio4hSq4YbmdF+FcUPipS1ztYlKZYOQMWENEqMlkNfMFSP4EWaeTQqSu5wU?=
 =?us-ascii?Q?9htshaPSdl41Tj+7BcUomkxZPjrVcWDZchW0OXOUvV0/toQcWZhJ8nIRX6DC?=
 =?us-ascii?Q?5sAtTLvnu5P6pBplHmsada2bHxUF/Y05cZPynqG5HFdxlrMCkxJsCXJwVmDn?=
 =?us-ascii?Q?5TRxuD/h3xITc+G19RMYSPzJgRvvnenRTe1OosElwLYINXx/qvpgs1YuCKJl?=
 =?us-ascii?Q?kOjb5Dv5RG3QsOmjSEFRuurneJPrVUzL4i7GmD9tx72SYYkvjQmce2/CqteS?=
 =?us-ascii?Q?EuEWoa3hNEI1l7oN2qXfYN2Iqcx54pjqQURc+byYonDYk4d2+mnVB7Z0l3/6?=
 =?us-ascii?Q?0zlYYn0+PU3bWMCYTkKlIFol4kCApXw4DWKWtO2cIDDY/xb2slSy2iPOxfQv?=
 =?us-ascii?Q?lXfWmUjvaaGoaq9vkG1zG2I8iCdJ+lFb+au1taNUW5y/jdmYM9Tedtq/pcvK?=
 =?us-ascii?Q?DGDXgvaMXYd4cRrGVGBtoyljcTjhVA5tawo857nmBx00KjvkSYtO8ahYX2BA?=
 =?us-ascii?Q?HY6j17KggZ8ucQBgaj2wflYILcyidddrmQLarlHgirDocBqqqw9ajDp7Masm?=
 =?us-ascii?Q?sCj6VWUanEN8On4NCP1T3qNTTznoWfpdaQEy/SKzTUv6VAgBDRamM30IGN2C?=
 =?us-ascii?Q?XiHSlQfo2mjLQ+B5DNWo3XzOYjQhEFwLpLylv5E6D4E5jcO503eZwyd6PqQj?=
 =?us-ascii?Q?Qz9cqP6kCeQxnAUXoKh+MnEz3IQf2JKZligKujqQwfKHNy0/9oXSvrgIWOo2?=
 =?us-ascii?Q?SQWNvI3nZQUxUabrrLPhHMFBr0TDPSOM/31L5/QaSDBaOtnmQbTDVFpe9e28?=
 =?us-ascii?Q?Xa9ncAVRr189V1zmpljbQShOKipCovqypP33FWDapFkM0NnXhflUV3FsKHjo?=
 =?us-ascii?Q?T5EV55j9XR7MkQDpO3xYskmjyjlFv1ZtwjLu5rnSFr6OW05u2e6C51SIn9CQ?=
 =?us-ascii?Q?LJQr5+9x9QOrAsmCcNJ2pYhFmbve75Tcvcw/cooIw7gJK4AqZMNyc58CEy4Y?=
 =?us-ascii?Q?zyRz+mK4/bDd84dKN8ArwKK+r+4Ec3gIX6jbFgPA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe77633-4997-4787-fc02-08daf8b567a9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:05:24.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBdrrQu9yiYMF8JjmPdFuexZZ8Rfh7avsp5m9XDnaq6byBA0JiA9YG7V0ullERcN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 11:04:29AM -0600, Bob Pearson wrote:
> On 1/17/23 10:59, Jason Gunthorpe wrote:
> > On Tue, Jan 17, 2023 at 10:57:31AM -0600, Bob Pearson wrote:
> > 
> >>>> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> >>>> -	/* check vaddr is 8 bytes aligned. */
> >>>> -	if (!dst || (uintptr_t)dst & 7)
> >>>> -		return RESPST_ERR_MISALIGNED_ATOMIC;
> >>>> +	if (res->replay)
> >>>> +		return RESPST_ACKNOWLEDGE;
> >>>>  
> >>>> -	/* Do atomic write after all prior operations have completed */
> >>>> -	smp_store_release(dst, src);
> >>>> +	mr = qp->resp.mr;
> >>>> +	value = *(u64 *)payload_addr(pkt);
> >>>> +	iova = qp->resp.va + qp->resp.offset;
> >>>>  
> >>>> -	/* decrease resp.resid to zero */
> >>>> -	qp->resp.resid -= sizeof(payload);
> >>>> +#if defined CONFIG_64BIT
> >>>
> >>> Shouldn't need a #ifdef here
> >>
> >> This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
> >> won't call the code in mr.
> > 
> > ? That doesn't seem right
> 
> that was the -3 of the -1, -2, -3 that we just fixed. there are three error paths out
> of this state and we need a way to get to them. The #ifdef provides
> that third path.

I feel like it should be solvable without this ifdef though

Jason
