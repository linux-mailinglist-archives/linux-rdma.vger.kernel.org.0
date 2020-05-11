Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941061CD8F1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgEKLwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 07:52:47 -0400
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:64071
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728531AbgEKLwq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 07:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN5NdbUxWbtz5LI4+nWOeHGa8U72IxDv+XMLAbRjFjYDsC9dQH5/Ev4pDSjVgYPA4JFkNHStT+gilLfdwWBOGa1LJHgQy0RKZTA2WUHi4aZOmVE/2DzNMgMu9EAQFkI4RrH82y8lsh7RfzmEJ2j6RSraX5wpspZiScevvsEMYCHF9LS/w0BqN5NiXJW2mUqojXdsAUGjo7xuy36w1a5qHaTtKwL/vk90+jPZ8B90XX1Ud8r7EHptBxdqYJO/MxjWld/nb1W5WS9fln2GaV0hWlRYq1JtUIgeJC4haWGfry21VeOcgpEWuyGReegN8e4WzRsPdNN35JLjnGo7JBCpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBvG1GkdJ7x0lgER9H40Xr3klQFhB0AUv4R37i82Kys=;
 b=X6Shm084Bnz0j6nSyrNQCGBD6ELTdkm7OS2waPplM2Oa5NXHzncVF+UrLn/DQ65KcQhEU0DXdlFu+JRF5cG8YxLjE8ccyEQzoB3ZhLlex0MFjvrCizDx1O29cD6xQBi2jsgsHToJ00MpyyWbAAOrQW7UcBqzuZxxCGGbygsBAnHsYOvAsmqSe3VZ3ArjPzjejt5AN0ZFtkzNSBYsetRNMD2QLdgVZNYv9T/pJ3t/mA6+RL2PVnjPyCkfh9WQTD6+QUHklWT5kDl9IEwy+lQ6QwhQp7GgYJnR9u4cMDV+3L4GIUdN+FHI8FUvi13vVFjZW5qEVB9QYM3kuK4ORca/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBvG1GkdJ7x0lgER9H40Xr3klQFhB0AUv4R37i82Kys=;
 b=nFBDTQD0kAXsjG/Wr6uSIrKbAMD+mck0N9rW4SggCcVKmK3q8Gtet7c0pOLcl6Dom6wEl6JBvetx7EMT6+CFZ6yYRQOuoOvwMbh30rezheSnMctBVrqnGMvNq6EYV8OjPk/Tu+aJxS63ErLLTdHeuSxen8KjQVpQzwx20ZtTPFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3978.eurprd05.prod.outlook.com (2603:10a6:8:3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Mon, 11 May
 2020 11:52:41 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 11:52:32 +0000
Subject: Re: [PATCH 1/4] infiniband/core: Add protection for shared CQs used
 by ULPs
To:     Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
 <20200511043753.GA356445@unreal>
 <297f6c2c-b64d-9a0a-08ef-90c83a4a7c0c@grimberg.me>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <cf46e82d-15cb-c144-e2a6-cba2a22f26f6@mellanox.com>
Date:   Mon, 11 May 2020 14:52:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <297f6c2c-b64d-9a0a-08ef-90c83a4a7c0c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 11:52:31 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63888029-c927-4692-015d-08d7f5a1c9f9
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3978:|DB3PR0502MB3978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB3978377C9E03B44AE3CED0AAB1A10@DB3PR0502MB3978.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQwBSMa3yeuzVuwjpegxK63vYp58pz5rP+dSok2ztOQusOBEIYP1g7YPJNHZ+TDCgtYE4E5M13SVfJviUBwT1/iSP+RC5zs+1kKPa40tj6UPg2kh207iAxbfd3uZdYg0wUgQbkkw/Vo8Oedl+nnjuSm/41Zyj2poRUbNALqu7lV4aUjSStmRSjfXtVv+kZPr8agXTBuzuJYRxzy+t9/3g7Rjkf+k4hrA3xMx/3smjXPwIEOY0VabRZVzYlcUYoZH3X3WtGF7fjIeBvwJSdMZT/wtzpw+DMw/J6ftzNLuLq1gwQiVBIEWiTleGspidmZ6s2Q5xeF2ye62H822jM1vPVk92yoK61+j3lf6E1h3Fyx4VM4yf2zuamjfT6HlOhXJJxfSwpxj6c4WjBj2S9ijHdBOgIKGcCryUDA92QDwiFTfaM2QUf8bBqGTE9dKqcnizCHCBZMIJ6b1A4ms5LifgEYNQdUmcdU/KnbdGFt1BjRF2q1EG0Jbn8914nD4aFRGCGgQG+a8Sd6EjyQf2sdKfgorLl21c6fZ6bjeBduYGRkPR8L4VProOMu5iqJz5Qkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(33430700001)(31696002)(8676002)(66476007)(6666004)(31686004)(478600001)(5660300002)(16526019)(2906002)(66556008)(53546011)(26005)(4326008)(66946007)(52116002)(186003)(2616005)(956004)(86362001)(6486002)(33440700001)(110136005)(16576012)(54906003)(36756003)(8936002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BcJTFUiAnPhc/0oS7usKcQpesidxofBtxG+iipgk4ZLlwwLDnCqT8Rnv+nTi8e3XVuuBewt672eRD0U+Y6UFu8HekDV5+dfeAStrTngf02XVFvt3SATo4fEEfeDOYtGmAIx138lR/feYCcx6C/VMw3T3gEis34Y7yks1NlrVBF1ABz1n/1T+ZdbWh4d7sO5GwqOiUAjFrVU6VFLpj58lhE/x0YK97E2frQbtLQ4ZkhgHDErLInpdlg5INLPyBWikMHqGLeLfDDsP2+j3X+uqFjx9aekffCQTk2d4AdzlzkH/xZFs+bjGtq3dkrP8lUwWQWR2PK+75pkgkFCLKF+HgqVW3dqkcWrcOhUnDwbNMIy388QP+cdPeQrjln2B7nKHgVxhNgZMq6HPKHkZy2uat0BsML/UMVda5sYKn+fDpb0h6kQs9CralETx7c3i3NAtfcP6GmwaXuR8TuLZpzr0vDiMBtdSK+sFe6YIWdaUi3c=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63888029-c927-4692-015d-08d7f5a1c9f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 11:52:32.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fC/GRwJbFEZ/TR4nM/fPJ4AF4koniqN928+kuvOgZ3O0UiiZRwV7Q7o7mvQaizIqfWmpgyF0Y7XxeExj4BpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3978
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 11:39 AM, Sagi Grimberg wrote:
>
>>>
>>>   static void rdma_dim_init(struct ib_cq *cq)
>>> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct 
>>> ib_device *dev, void *private,
>>>       cq->cq_context = private;
>>>       cq->poll_ctx = poll_ctx;
>>>       atomic_set(&cq->usecnt, 0);
>>> +    cq->cq_type = IB_CQ_PRIVATE;
>>
>> I would say it should be opposite, default is not shared CQ and only
>> pool sets something specific to mark that it is shared.
>
> Agree.
Will fix.
>
>
>>> +int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 
>>> cq_period)
>>> +{
>>> +    if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
>>> +        return -EOPNOTSUPP;
>>> +    else
>>> +        return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>>> +}
>>>   EXPORT_SYMBOL(rdma_set_cq_moderation);
>>>
>>> -int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count, 
>>> u16 cq_period)
>>> +{
>>> +    return _rdma_set_cq_moderation(cq, cq_count, cq_period);
>>> +}
>>
>> All these one liners makes no sense, the call to
>> _rdma_set_cq_moderation() in this function and above is exactly the
>> same. It means there is no need in specific function.
>
> Agree as well.
I thought it was clearer this way but I understand your point, I will 
fix it.
