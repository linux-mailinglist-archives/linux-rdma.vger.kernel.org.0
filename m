Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC450207607
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbgFXOsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 10:48:36 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:21379
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389187AbgFXOsf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 10:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtEgKmxPLukL46m/qJsy0L59XiARMStyLj5MBUTLSlplX1k7EOw7Z8uL9fu+FT7YecfjxnJ1ntgUfh79JuSpzSeukbj0ubkjShj70Mbc4A5emOtqtHlWVBFhk6KN09mDKmZytBztFpOu2IydXKE3rtNRbOfgiEHt24DjXnv708wgR1LeZcLNs1f+FUcy6kQuAmb8j0VsnSQEmr1L+FwZybfEt4lcctwCz9FSNm5mI8yC6XZARZ2WUR2iTn068fPXn3ZhdbjZKci6CptbA9GBwV7u7jWLPQrmWf0p9L4xx5b79/D9ugg81OKMbhhVJFqfZSdKLcPpOKSBlKpPBPxaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXVICx2etTdEQiB+1tp/EcGBZeOfa+nYJp5Owr9gYkg=;
 b=LiPDSHXGCQY0OrK6Ri3FAgjmQyYEH7rRl1GFYEKfgapZVD86ZGXlXwaRjsyOxP+M/R8rUJ09Bob7ZYiGa+mb+q9LWdXW0bV8bK8woK+hkjguMew2eQOPw0YjlwoFYaopQQCZDSsey1efPqDY4n29C8eLc4Ov9b5jGpdQ6EFkVJf6QVcVLftKi1871BzVxlKXYd4QFMKmDvfnfcrlNffcvmGmdkoyl0J2F6fZPgRDCUNhnmBs3RCMWr5BKdN0f9din4e+MsKnIcgJFgv0GzrCwSKKCGpUgtFBPOGa2QYd8a2+uw8fOYjCFV1Y6lq2pPOSmyTfONTcJt3264SBovIc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXVICx2etTdEQiB+1tp/EcGBZeOfa+nYJp5Owr9gYkg=;
 b=c8bdl4syROONyiaCFvn2cJgSppvrNmc+W5Ij8ROIEyEKAgySQCYAq7c6Un/lxRAdqWQyEM4egCHOLJnawc9lR+7Q/MMxreX6eiyg7vr3XFkkA+7aJrn4eeHEWOGHQw8MenuK7mfAScHvJM95C1ezQmUyJCPMXj3evax59J+rJvw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB5348.eurprd05.prod.outlook.com (2603:10a6:208:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 14:48:31 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:48:31 +0000
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com> <20200623181506.GC184720@unreal>
 <20200623184940.GN2874652@mellanox.com>
 <d5206962-69ae-48e7-261b-485db71d2a41@mellanox.com>
 <20200624140047.GG6578@ziepe.ca>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <9e018ff8-9ba1-4dd2-fb5b-ce22b81b2c52@mellanox.com>
Date:   Wed, 24 Jun 2020 17:48:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200624140047.GG6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0097.eurprd03.prod.outlook.com
 (2603:10a6:208:69::38) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.10] (93.173.18.107) by AM0PR03CA0097.eurprd03.prod.outlook.com (2603:10a6:208:69::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 14:48:30 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7a3b3b7-9516-4853-747c-08d8184da9af
X-MS-TrafficTypeDiagnostic: AM0PR05MB5348:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5348BE73E08FCF8A30A7C7C3D3950@AM0PR05MB5348.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fn7/rB/YPbaCafomzAMhnt8GTomUEHrOqDKiGB1j786DN533NHvxwjMfDJLWeVqdCJ6gFZSLA74TMtCYJh4mMnthREvjLQ9ANoZrYRNvu7SxHjXnqtufGmUqM/gmZQ0ux7FXi9BYE5N1KUvfTYUcnPZg9vE2mmy0hXutsRoteUst2OJ9j+xPMWQwp5A8L1GsA5QKXEzWiJbI2VeNy2zi3DThiuaRfDDsAnEIDzkN6Ldmd9/AJGVXz3BIyjCMF5S3RRwgcExGtFM8uWvj6Jd8Jj+3gihWOB3mYme3txEoFdut3oHX6k8Aqfgj64bg0n4xaMIFyukDbs5ZSi4zQOH3hhZL+bl3aYlLKWJr8ZfiBuhzu9b/5N8sn8T+Sv1ghB6O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(66476007)(66556008)(6666004)(66946007)(8936002)(8676002)(6486002)(53546011)(31686004)(26005)(52116002)(478600001)(6916009)(2906002)(186003)(16526019)(4326008)(316002)(86362001)(54906003)(956004)(16576012)(2616005)(36756003)(5660300002)(83380400001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Yw0TBnHvKsDYNsXVrg5pOBhfLmdAYoTjhYKrxdDItO5HahczDob/VlDHNorNiKyWhfYBG1nD5wPSTv+hHmA17I7RS0U0E3aBSoIJ8NDRo2+fn1lmdtSLK42i2GoPNAMAuwb+xhsW6WJRigP4cxf4woA3v1tcl37oeK1UV2a/zIDgTaLtsHXJ/Njl19zy/q8s0y0XdB0rnb6z1z2G+lxPTF7cV2YBR1NybA5qUohWhCvY1DmjIltGvAWHCkl2Fma63W83SoOzSCqlHW+x0pAQwnsCI1If+y3qBIPS/KWagCcVZp32P+0vUidcmJVqyWcvAhf4SlHHPvr8ax3g7sxUibWeP1E8uZ0NTpJQd8s4q0lXpplk5c54cY4Q5XRXU2DitlLibP4VOP5e+UybAAKXTlYQDd/ZCkmai9JkJ/zRaZ9TbE9CchDylKUNaVYxw7VGTLGBFyEnSD6jdfeChXGnQFKG1LFtQf2HXvTfpXQ+mtcCRS1yrC73s7dzL68ZPUuP
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a3b3b7-9516-4853-747c-08d8184da9af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:48:31.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erK+tAn2oKysmf3ztGs5ClecUcBQmaZ/14bcEzguWKkTJ1H9Ac0oE7/F0KmF33nT3/w1vbD369/1G8dgFRL5ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5348
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/24/2020 5:00 PM, Jason Gunthorpe wrote:
> On Wed, Jun 24, 2020 at 01:42:49PM +0300, Maor Gottlieb wrote:
>> On 6/23/2020 9:49 PM, Jason Gunthorpe wrote:
>>> On Tue, Jun 23, 2020 at 09:15:06PM +0300, Leon Romanovsky wrote:
>>>> On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
>>>>> On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
>>>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>>>
>>>>>> Replace the mutex with read write semaphore and use xarray instead
>>>>>> of linked list for XRC target QPs. This will give faster XRC target
>>>>>> lookup. In addition, when QP is closed, don't insert it back to the
>>>>>> xarray if the destroy command failed.
>>>>>>
>>>>>> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
>>>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>>    drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
>>>>>>    include/rdma/ib_verbs.h         |  5 ++-
>>>>>>    2 files changed, 23 insertions(+), 39 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>>>>>> index d66a0ad62077..1ccbe43e33cd 100644
>>>>>> +++ b/drivers/infiniband/core/verbs.c
>>>>>> @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>>>>>>    	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
>>>>>>    }
>>>>>>
>>>>>> -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
>>>>>> -{
>>>>>> -	mutex_lock(&xrcd->tgt_qp_mutex);
>>>>>> -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
>>>>>> -	mutex_unlock(&xrcd->tgt_qp_mutex);
>>>>>> -}
>>>>>> -
>>>>>>    static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
>>>>>>    				  void (*event_handler)(struct ib_event *, void *),
>>>>>>    				  void *qp_context)
>>>>>> @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
>>>>>>    	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
>>>>>>    		return ERR_PTR(-EINVAL);
>>>>>>
>>>>>> -	qp = ERR_PTR(-EINVAL);
>>>>>> -	mutex_lock(&xrcd->tgt_qp_mutex);
>>>>>> -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
>>>>>> -		if (real_qp->qp_num == qp_open_attr->qp_num) {
>>>>>> -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
>>>>>> -					  qp_open_attr->qp_context);
>>>>>> -			break;
>>>>>> -		}
>>>>>> +	down_read(&xrcd->tgt_qps_rwsem);
>>>>>> +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
>>>>>> +	if (!real_qp) {
>>>>> Don't we already have a xarray indexed against qp_num in res_track?
>>>>> Can we use it somehow?
>>>> We don't have restrack for XRC, we will need somehow manage QP-to-XRC
>>>> connection there.
>>> It is not xrc, this is just looking up a qp and checking if it is part
>>> of the xrcd
>>>
>>> Jason
>> It's the XRC target  QP and it is not tracked.
> Really? Something called 'real_qp' isn't stored in the restrack?
> Doesn't that sound like a bug already?
>
> Jason

Bug / limitation. see the below comment from core_priv.h:

         /*
          * We don't track XRC QPs for now, because they don't have PD
          * and more importantly they are created internaly by driver,
          * see mlx5 create_dev_resources() as an example.
          */

Leon, the PD is a real limitation? regarding the second part (mlx5),  
you just sent patches that change it,right?

