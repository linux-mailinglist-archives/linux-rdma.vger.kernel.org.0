Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2C3B4768
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFYQ3w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:29:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12076 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhFYQ3v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:29:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PGQ64V011991;
        Fri, 25 Jun 2021 16:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mz1fmRulXQ3kJZtd118fm14nx6eVdLq4oCj/GyZxD+M=;
 b=ibHRhmTY3QqsHsi29LaOE4Eqik+ACQ9he99b7xp1v/rk3m5TlsvOfED6ebEsa6ZhqJJY
 Xxkd+98myHvvzFVl+XEGeSNqcA+SMZ3v/cH9MVYhZuXenQC81nexJp0aYqTV/yZDmRCe
 h3lYxMK2PPX2OCnbPGJ8I4qqzbCu0036IJZNPoOi58plGCy8+gQ2yocxLPVwpZ/ki4xn
 XybUgUE7rfAY71VVp4VwhXkAgSxsfw5x7UYF31XUAwNeXq4mc9oSqqP9lDIO3/eLcip9
 ri0wC8RUAgXOofKrLiitwYidJXAr8yzQpQ/1YhchNKs3z8P8XzCcQZe6x83KPtYP/pAk wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2kxsqph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:27:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PGPPke129715;
        Fri, 25 Jun 2021 16:27:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 39d23yb8vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT/lhmdYp6rdrfG/c1LD9W/QVcF6EpLfPP+ifSLo1KMBtNqAR9gwEmVsGTEIslnMqUmbFTx4lRwdfnkUrvCrMt5Td3W6NUyCBx02tqbJSrnUJeHeBDiHXUr68FjUL9IiqmCY7OSka31kFuA6pk2kmSIZbIGnDRdluQWB3bi0K11o4g9FHHYmvJH+U08mHlqR8w8Gxa1IZB8gMwTHWJZBbeDKnZgKrCYdjOkL6nIPApsy9k5nT9aKJE8mPZVkWNnuxMAjb2PHc/aiPlBpm59gD7ZCvap4ysREzUIO+Xw+bPITvSt5fi38SUg2z4SbVPircZ2lCU8RV/J5L1iYKAiHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dYXc1mul6CNeF39aLTxusqdcOb6vlyYI2dsYvuWi9w=;
 b=jrE2jXRklJiCEIbyozo55xDfPtv7hqiY/eH9evIEaC7fxyrShgRAYrr6FlY6A/nPI0M4SqIHby8Ppqhz9dv1xd3/4g6edN0ppapoeZoNP+6MJR5w8llfbh+t50tUHjGbB7NqhDqZFzxae0M0edUYUDNa7VpAd4Ad6IMkiCmT7C4GIPNFO5DAvTRG2/ldd4gMYAFSz7HrKNJhCTa5MACR0EaBJ/srjEqi9IbTPBr+FPu678wlIJJvkm1c0sYyeBTs2jU/6R/C1TIf2v6e/ZXK6DWNdVd6gEr8dae5MHJOeDEJqUO3XwdDbrdtCpM/MdudmA708EqO8odlw4A2fPp7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dYXc1mul6CNeF39aLTxusqdcOb6vlyYI2dsYvuWi9w=;
 b=jZwpCPBcFGar6A98/4cXIGSfbBffY34T2IUdqiDk45S5JQ1gDitHTDpzglA65S70mvN/NKWkV3QdR2qs7zPXlP0nzc6V65bMf4GA0fLHlQ6uUEIz28MxdHfWm2QD080sECMY6NupPksVZbEtx6Q+VlC1tBD6DJObWV1tU9sCD0Y=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by BYAPR10MB3494.namprd10.prod.outlook.com (2603:10b6:a03:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 16:27:23 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559%4]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:27:23 +0000
Subject: Re: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
To:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
 <27a35a75-813d-ef1e-c9ca-d4ecbc5a95d2@nvidia.com>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <b87ede5c-e8f1-c146-51f0-fda4b411a4b0@oracle.com>
Date:   Fri, 25 Jun 2021 09:27:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <27a35a75-813d-ef1e-c9ca-d4ecbc5a95d2@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2405:ba00:8000:1021::1046]
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ib0.gerd.us.oracle.com (2405:ba00:8000:1021::1046) by SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 16:27:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c01417e0-9a34-4d32-0081-08d937f61c79
X-MS-TrafficTypeDiagnostic: BYAPR10MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3494649CC39CD03CABC68C1587069@BYAPR10MB3494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iE6PvcpceEXZ6Bkm6oZu+GiXI/fbfjFXC7/JB634N2BL7nzRpCsTGgFcbsHvpdPKRduFsEye3vhEMly0zbpLtpHmg8lsobOGHRUj0vQTRQbMemY96wfzjiQxuK88R9MINeWz1Gwo7yvCDN9ZUEZWdqqVkZsKw8SDOoXFPDMfPuc0THkDJMdCSusH0iWviWBVKZhZb+ZtY2N7n9ozE85qSYwovQJ6IXBzs2KH23VnKAftbluBb5h7ynwR1+P6tK98lnW20zAS8XB9JzXhI4s3lOSwdgTCOyLXwfYBr0MNMNVJxG0VG4cy7HbEJbUYM9Rj4khp5obrTdTe5uTFX4/YTdoWCB1oLICgW/qKlkmCGjh7wo1Vp3D1rOBjM20b7n7a9+8QeKh/iIkO8vlkPkvxSwIChvHTqDzGxHpmI9cQaxYmtIyY/7p1+Ar/O1/WXHUxds6hQiyEC0mH/XpF109LZcxaoXBk+MA1kqtvgRGR3ma9mRHG66EtzYmK8mTIzJwGl1EsGz3QSmgUZCQFfQEU68CFkkUOkDFkURx5pasYa1Ucb9zUIl2VsRtzxe6CVLOJGqRaI9GjP0rcXygXnCNikDJa+ckVjI/Vn0RWOWx+rgb/ULk/ve/ekrSvMKcJA04zYinlfULxnBsJXYN8lUYapyg4VLcMLqmNcA1AB/oUbyTex18szPH9HNzIRUXGoTeZqrVlZkW65N2Tw4BEXBCiNd2VvSOgLNxkmlgg81cxXq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(2616005)(36756003)(2906002)(83380400001)(8936002)(44832011)(86362001)(31696002)(38100700002)(52116002)(66556008)(478600001)(66476007)(53546011)(8676002)(31686004)(186003)(316002)(110136005)(6666004)(7696005)(5660300002)(6486002)(16526019)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?HFC0BVwfDTWT8nXTlJcAW/BbftLjgxsGIFKYcNLvpsqGLExYY5pVjayZ?=
 =?Windows-1252?Q?SmBQDDKcRK2JpD9EoNodt/EpzoRc0XRp2cKr8gfxHYqToadHNgiCAtvh?=
 =?Windows-1252?Q?ijFpvA/CL2gbj+xoE2oW2KqVRuPazP8J508DibtmiYR7f6JtCHXKad5C?=
 =?Windows-1252?Q?Iv2OomL4+e6MPpAcEz28n4Ay62EIXQs8xI+mUhsTsCjqu42xYVAI5QUJ?=
 =?Windows-1252?Q?dGG4LhQN7Wy+xDfG5RIfsjbZDQ1AS2eDxdk/hdlFxwEvuJbIHL/xo6uQ?=
 =?Windows-1252?Q?wdKkCkf/XEp67RqjpdHQEETJadFxH1IcMgL2NU7UeGm3MF16rvhy8B+q?=
 =?Windows-1252?Q?brhSBc/jU6Sud/7ov0kbx6MMljiWz3Au9AN+wnZk/B6lLI1WubMTzkB4?=
 =?Windows-1252?Q?TQ7eo9KsE4pbjqmCOObWSp6HQvaCuq3D5BvMStgmhQ3J+MZFVVZjX3kV?=
 =?Windows-1252?Q?RBaSFr6Bwzng5kVUbQ/H4qLKaq2yahfdHGa38moV0rUl+PgCNuiPNfHf?=
 =?Windows-1252?Q?PM7EB0C7Hy3R9XxiAsGdUGqoT+RHwCYP9ABXlg+AE9sXCgfSVie+1EoP?=
 =?Windows-1252?Q?STbcUYrFRf+X8TwVan94ahGYaAnSkOyT+e+m+rXOBhbZ92MUCViMwEll?=
 =?Windows-1252?Q?N9JZHrT0nB+QAsiMSNiHw2/YP3gFDhmEBJrAijvkNLe+yEfsoRR9VDDp?=
 =?Windows-1252?Q?eMbI9iOUreo1x+R99GJlEBJVeZsfVvOg75Fr+qWptlXYpTMqHQ+wPM9f?=
 =?Windows-1252?Q?U1NSkCOJjvEHAv09ykmjnWm8BgG1DSRa8qsfeLJNYBfclMfqZPyzEBI/?=
 =?Windows-1252?Q?I/NjoH8NB4wKHJmjC/v70zu0s82WmPFvFsn5JPDw/QUDKhsMxxd21YhZ?=
 =?Windows-1252?Q?VU9/XP+UC1jfX4Prat+95bfo+rTbLjdBYoCMmcv90yQ3npA275zu3w8X?=
 =?Windows-1252?Q?9wq/dzZarJlOKQxKaoMCiKYmEpxcE2FMsmJ8LxdrAjOYlCzF4OUaV3ZI?=
 =?Windows-1252?Q?Td8XgvrA7UDYAW+pOq0g2FirGeOX1FksKQlnmOrsWc3j0cgXQb9W8cd3?=
 =?Windows-1252?Q?r6ZZdnQg6RUqWLAizRuam9U0WbszqxYal/u70OY1qpPTOFc1JxNH5q6v?=
 =?Windows-1252?Q?YwXGdzbsF8Y1aEu2BO36F7w0eRrPaPBwdLXDRPFPZQvx8JDvUtRpy93G?=
 =?Windows-1252?Q?FCsOWY0JMS64E9ZX0VkkEhxmBcpjkNVabvkz/ajWOTlGhV7cXdWyp6uk?=
 =?Windows-1252?Q?oZ1BE5sRxATgJgbLjRMEJHjCVHk9iAw3nThq8W/r55gJ0SsTNam4xV9f?=
 =?Windows-1252?Q?WfNjUCgIG56FpakN/g8y5v+sn7RBcnZ/8G4/ff9AGc3ek6whnC4/lrGb?=
 =?Windows-1252?Q?E+zGyyW4uJCxREAOqo9RcBd/jF12+LWbXo/y3nBgU2FjBjH8jp3Rei+x?=
 =?Windows-1252?Q?butaOEUMj0RLZj6sTW7NaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01417e0-9a34-4d32-0081-08d937f61c79
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 16:27:23.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXbtA3JjNUxyW0kK4vZ8kSi9FF1oEF6dppdFqvAZJIm5mYXINghakSHLx3igFP6iF7T0Ut+okTv7MsQR4+Oc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250097
X-Proofpoint-GUID: dqCwajx7Qbmq1l39QfbiAMc_6CUi5vur
X-Proofpoint-ORIG-GUID: dqCwajx7Qbmq1l39QfbiAMc_6CUi5vur
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mark,

On 24/06/2021 22.49, Mark Zhang wrote:
> On 6/25/2021 2:55 AM, Gerd Rausch wrote:
>> Fix a memory leak when "rmda_resolve_route" is called
>> more than once on the same "rdma_cm_id".
>>
>> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
>> ---
>>   drivers/infiniband/core/cma.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> index ab148a696c0c..4a76d5b4163e 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -2819,7 +2819,8 @@ static int cma_resolve_ib_route(struct rdma_id_private *id_priv,
>>         cma_init_resolve_route_work(work, id_priv);
>>   -    route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
>> +    if (!route->path_rec)
>> +        route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
>>       if (!route->path_rec) {
>>           ret = -ENOMEM;
>>           goto err1;
> 
> If route->path_rec does exist (meaning this is not the first time called), then it would be freed if cma_query_ib_route() below is failed, is it good?

So the caller performs "rdma_resolve_route" which returns an immediate error,
but the expectation would be that the cm_id still points to
a valid (!= NULL) path record
(even though this error indicateed route lookup failed).

Which code-part and call-sequence would have such expectation?

I can't say I'm in love with this approach either, since the code
makes the assumption that "path_rec" (if != NULL) points to a space
that was allocated by "kmalloc" before and can be overwritten.
It's not permitted to point to something else.

But "__rdma_free" makes that assumption anyway, since it unconditionally
calls "kfree" on this pointer.

So there is precedence.

Just my 2ç,

  Gerd
