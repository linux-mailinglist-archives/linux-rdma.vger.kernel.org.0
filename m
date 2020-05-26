Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67C1E2104
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgEZLjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 07:39:40 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:22080
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbgEZLjk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 07:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8InYo4w3z/Zuzoo40+/1HuAS7crO/lfZ3VE2AtRpJr5VzHFjt6yPPScHU1RmhdMiYR0Xal8Z5wp/A+gyMwCo3Qizj1QIE+v+bYGKzxKyCsOmxuZseOWTOYF/8i+aEyccsBy2Di+ymGupBorS+dghIF66c859Klcn+4cr7O6HgvOHtlaYe512r08fChk6bllCsd3Ik8pNfSzb+Q65lGAezkkYj+vyMQGaznRtJce2sjPDeT/ztt2LTJ7+CYYtaj5y4/BvqjIbLph2mcY18ewU8G5TEKFHhUhCy/Ji6XoEpdfXXOyFo2/App5TzdolTMEAHrQZit3mHD7ZnN/JSgeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9KfwhR9kDNa/U5rYY/OLui064dMqwthP0vfYXoeJag=;
 b=WDiW31lC3B49WN4jtDnHhQjH1XWnj12X7gkFMgiuBUfG959kIRWsn0d7RZyF5KStgQM1YFgUsNoJuRFMimGb5iYMM4pCyPwFzSqLt6kZdArI/TWwy9YP87aSv67hRFY7/YUfmC3HmIwgBDPP4G04LBeCQA4DWG+iEeciFEpo6hJSflzhNBSyZUEfGNIANhTnDt8P5yF99eGJPjzw1LwzAZ24aTcOhi7sSy0tY3RK/H7yjDENFjEIxPtk0PlM60reri+1iZzG99eXprfkMq48jaTAWN8Wsg7rSaapB65i5m2KY70oWAXp6nD0AK3OcT6ZGPDaGh2HPJhjk+vtrv6WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9KfwhR9kDNa/U5rYY/OLui064dMqwthP0vfYXoeJag=;
 b=d3u8P/GvmWfLqNoifIk8ToJHeHodcnmWo1I/sIBeKoVaTHryMXPCFv0Cx2I5KYC+LBtTQwsjnHf0z2JXr0jdya7JWuGF50KTOc7/zvepSVs5rg45GfRw5HCyEHGLqNSSODk4BHcP+/sQwaWB3Ie3Fm0+igOcrsPfoZAqaKkBv4Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4059.eurprd05.prod.outlook.com (2603:10a6:8:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 11:39:37 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 11:39:37 +0000
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <20200525164215.GA3226@ziepe.ca> <20200525164713.GF10591@unreal>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <ce3205eb-44f6-f2b8-6b19-4547092f6a88@mellanox.com>
Date:   Tue, 26 May 2020 14:39:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200525164713.GF10591@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 11:39:36 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8be696d-287d-43f6-a466-08d80169780b
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40594B9072DA57C5224AC1D8B1B00@DB3PR0502MB4059.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bc8wK1loKKYYp2kpJJoPM9aWHfsxcq47rKIURhPM0/EoD8uchTpmjp62dbt/tx/ch3adnCnpUNDY4jM3uwqgIDAv25rSKu3ZiYB0beASivJnRtKTBGjHPabUbB5SdCfkaTTeELhf8izc75Eaud6l+xYQyi5q4kwkteaCijVdtZFDK5WtcZOvVIKtzw5qRZeb9k7THb2ULMm0grdfsCxs+gaRgVlTwZgX1uSb1kHO/vUWmXb129Tyf82HPzB/x2Ta0m+SYi2f+3jWWRjOyxSrHjUs/mQleMa+I4Btl8cBRgsSgQ58evF+NccQMKCHVc9AGau8r1Dc39x49muj5Om+dLPs9nvPgdSXFle5a6RcMS3MkGdGDbfnLAXG1P1oBGW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(54906003)(31686004)(110136005)(2616005)(956004)(26005)(16576012)(66946007)(316002)(478600001)(2906002)(6666004)(16526019)(66556008)(66476007)(186003)(8936002)(36756003)(86362001)(4326008)(52116002)(6486002)(5660300002)(8676002)(53546011)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IX5GE0Xe3Mox2zOA3kTaQqDDc51kljjvI7QszrBx7VJjuj2M1da2NCvfRFKgm4gX/zsjRcT0J7Kt0/6l21tzgjts6stvGZXW7kPIdGL27XWI+sIRsbTzSyVeom+O8knHST0y5NwtvrwBxb2KHLRl/zJyk0wy+DC3i8Y01+RuqergS2AdtGc/FEhSmXoxlGrBomSamEDiTFdwpvMzJ0EZum2vgoXOj8dOR0pA93uLMvanrNIbZZEdu7ANuyM5Iio1bGQr5LyeP3L+nAWNbUPOqiX9SUD37TXwxYxVZwcslQkDmodbWd/25C/8XeDVWLDU0QoxaLn6p0wnJ2yNPOU/7/bVTyttkY154HT8jlPsKvpEGWRV+gYOltRQPHKQheE540tgglPk7TrSrXecUynxhli3trek8LA4JENJXcJ4wZGAplJVkU31dkoxWtOPoGO0Z4gFl0snDIm/N7TmxpY5FYU+l3eGdf9DXnVFXihGoS4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8be696d-287d-43f6-a466-08d80169780b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 11:39:37.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USg7TZBaEyLpRdMjABVBMzSAUOwslJxM1hgRgCW1+XKbWcf81LkR9E84y4mwmfKMC9KB5m2SwJbX/YTWj/xVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4059
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2020 7:47 PM, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 01:42:15PM -0300, Jason Gunthorpe wrote:
>> On Tue, May 19, 2020 at 03:43:34PM +0300, Yamin Friedman wrote:
>>
>>> +void ib_cq_pool_init(struct ib_device *dev)
>>> +{
>>> +	int i;
>> I generally rather see unsigned types used for unsigned values
>>
>>> +
>>> +	spin_lock_init(&dev->cq_pools_lock);
>>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>>> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
>>> +}
>>> +
>>> +void ib_cq_pool_destroy(struct ib_device *dev)
>>> +{
>>> +	struct ib_cq *cq, *n;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>>> +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
>>> +					 pool_entry) {
>>> +			cq->shared = false;
>>> +			ib_free_cq_user(cq, NULL);
>> WARN_ON cqe_used == 0?
> An opposite is better - WARN_ON(cqe_used).
>
> <...>

Is this check really necessary as we are closing the device?

>
>>> @@ -1418,6 +1418,7 @@ int ib_register_device(struct ib_device *device, const char *name)
>>>   		device->ops.dealloc_driver = dealloc_fn;
>>>   		return ret;
>>>   	}
>>> +	ib_cq_pool_init(device);
>>>   	ib_device_put(device);
>> This look like wrong placement, it should be done before enable_device
>> as enable_device triggers ULPs t start using the device and they might
>> start allocating using this API.
>>
>>>   	return 0;
>>> @@ -1446,6 +1447,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>>>   	if (!refcount_read(&ib_dev->refcount))
>>>   		goto out;
>>>
>>> +	ib_cq_pool_destroy(ib_dev);
>>>   	disable_device(ib_dev);
>> similar issue, should be after disable_device as ULPs are still
>> running here
> Sorry, this were my mistakes. I suggested to Yamin to put it here.
>
> Thanks

I will move them to the suggest location.

Thanks

