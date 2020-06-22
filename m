Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5320375A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgFVM5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 08:57:37 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:55553
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgFVM5h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 08:57:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8+EVIJ2+bV32Kd/mtvLLGI19hAJsPRHZ7/4WEhk2yhoEjXfgHjN6kDfXL2aWbZNRRCf8PzoLwb9/Vj6C8fdPsK+ZBjcrQ5BV2G65Y+9e3cAw3BOwUeIBzbB1FrLwZHiHm7k+J/TGjgAvd6wtnNv2HKNKi+eWtH4yq287G4Q4v6ksjXSp5nlmYYoJu/j1eS3jvK8zEHcUUVNJ/RzSg6T2+ugAtn6MtPO3eJFFgv6AN3pSZTdjKRgTgGG1D8nYD2WIMgu3JVACcdmkDXkAq5hir9N7laaQeT/zbV3CGgTnCIPaXOyF8RYOctoVEQsixPJbYrA4CGEoFslzW5ox4CTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rscchap5Utv+BP3TCCbgPeUTBvLEaKLgLo6V6kAFdFc=;
 b=Z02lC6O1tm7H4cCfx58Apn2VNnY2sAVcYJaVCfN8jF3bu8fuuUg8r4oAtKN/zS2GUsf5zPxDhTkbHVk1IoqVqMa2An2yoESh5JoVgJRNgNfOt5QGpN9ZndgKKd7im53thndOtzj3AEHuxwBdILeBD5nsL+e6dfKDFtE1b0e1g5j4NShskGC7YRCugczIGW2jpMpajdWpmDTtkW0JFW0UnPyE+a6jFM7GKd/v7r5YPJjY/rpWBSudK/Hj7O+QahY8/kvh6EbJCSwMcIGgUAf9u5m0sGw4HVC0NqOhPVLaUx5ZoUhTZZe1t8OPZa0TZSFKskKWtp6C/pwDJFuUQR5g7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rscchap5Utv+BP3TCCbgPeUTBvLEaKLgLo6V6kAFdFc=;
 b=BarhiTdQaTKspEUkBRKhVeB6jNOf2x7mTp6N8PVRWh0aFU9t5A7naHVHLIOmQRd6fTbbRTavo5XoDB2IwJcPBz57joMPUc85vqdAvvEdwcUWeD2uS15axM5VnG+zgf1Q+yMZ0pLFpuuQepa0BwcvXHTrn4bZY9reTWbzG1rQlzI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB4321.eurprd05.prod.outlook.com (2603:10a6:208:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 12:57:33 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:57:33 +0000
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Optimize XRC target lookup
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20200621104110.53509-1-leon@kernel.org>
 <20200621104110.53509-3-leon@kernel.org>
 <20200622122910.GB2590509@mellanox.com>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <3ee325e8-6872-22a8-4f2b-e1740d15a194@mellanox.com>
Date:   Mon, 22 Jun 2020 15:57:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200622122910.GB2590509@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.11] (93.173.18.107) by FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:57:32 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20bc0802-d825-4a0f-eb1e-08d816abd49d
X-MS-TrafficTypeDiagnostic: AM0PR05MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB43215CAE3838C0289821F89ED3970@AM0PR05MB4321.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kzf5bK4Ui8u26S8TyLPbmOUfI/W6HcJyLPV8UzxapoUZ/iXMyPtlvhVAbE+07D19sYw9Ja1qLl5cRiArcgkKAiq4Tmf2FFUZWJlmetn/XbNxN9KfYSSQeVEe/2Mc/BAHSNI1AbHImj59O62TEkUrQHWi4tUqQAS7g//+NiM0sZQjCzafvPuxc7x8rpmrpa4Fk/U6e55ZkzzvPs/UOQxBPYsn6w0F5WPrybmH4nrUIxDfnC9ac/s0QKTCTgphkz22Vj+JxGpIEW2G2u0LmBDD4QOqRiide4mEV5nBLSMpOjX3t95ouWQahr4LAR5jHLQDbP1anUCZf3VcMGD/GQozSm6J9oCGSZDM3Kt9nh6EkBAmp15E3DSStipKKfBdH3qm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(4744005)(2906002)(16576012)(316002)(478600001)(2616005)(16526019)(956004)(186003)(26005)(4326008)(6666004)(8676002)(5660300002)(8936002)(110136005)(66556008)(83380400001)(6486002)(66476007)(31696002)(66946007)(53546011)(36756003)(86362001)(31686004)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AlOSCYB314qLeyxshCcjg/7S4UeyDjFD3XAA59FHot10TuctdfjOcLa3Y6U95NOnvsUGLSPrFhdpPk05JXdM/omO/IUbd2Ns3j6wohkXo+g4CgHVurcLg2KL6SMLxsELHNv5Okpi2cWB8fbKK8FAlKRRcHu2evGGMt8Aico3cOcm27/HdJOs0Wn69O4m8XTe16McSO4+z4wfyCibI2WhSQ2qCq6S2ZiR6FG1oEs0hoFZmyLZ0Mj3I8ELBGhnTtsPpS694Lqp2hEBTGJ4+BV9k3fdPntqGLLuaZFKawNS82E5XVQq1Jb3eby7j9zYt8o3rHAsaW+oQnN6Ut2YEd7YZ4jrDCDjMOnhsiMxgu9qmjghmGTkGii616i6ZoX5rmedbEOme12kwgdvR6M/j3JGvqoFWIYlfz1S12wlEHm3ysN6kql60ef+odCfuDoFgaAcAR4Sz9wycW21rFAkVzNc4QYmWiv736A5P8Fe9EMrfd3yG/B4Xsyc2G7Y5EM6CnPV
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bc0802-d825-4a0f-eb1e-08d816abd49d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:57:33.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ5Kz6JUGFQZdxNuiPybAFWpXFy01Fu9uk3M6bP54UrDZ5/3R76jr0pKhUQJSUusw3UIACuZV+bExmc3zoMKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4321
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/22/2020 3:29 PM, Jason Gunthorpe wrote:
> On Sun, Jun 21, 2020 at 01:41:10PM +0300, Leon Romanovsky wrote:
>> @@ -2318,19 +2313,18 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
>>   
>>   int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
>>   {
>> +	unsigned long index;
>>   	struct ib_qp *qp;
>>   	int ret;
>>   
>>   	if (atomic_read(&xrcd->usecnt))
>>   		return -EBUSY;
>>   
>> -	while (!list_empty(&xrcd->tgt_qp_list)) {
>> -		qp = list_entry(xrcd->tgt_qp_list.next, struct ib_qp, xrcd_list);
>> +	xa_for_each(&xrcd->tgt_qps, index, qp) {
>>   		ret = ib_destroy_qp(qp);
>>   		if (ret)
>>   			return ret;
>>   	}
> Why doesn't this need to hold the tgt_qps_rwsem?
>
> Jason

Actually, we don't need this part of code. if usecnt is zero so we don't 
have any tgt qp in the list. I guess it is leftovers of ib_release_qp 
which was already deleted.
