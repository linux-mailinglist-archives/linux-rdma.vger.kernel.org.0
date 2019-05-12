Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3598B1AB79
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2019 11:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfELJbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 May 2019 05:31:48 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:12198
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfELJbs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 May 2019 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uOVn9nvP5gm0JcLX3kcTi3Bf5MxXPqmrqJZmIfDtL0=;
 b=emJiVOWEQkfaGv0iFsfmzQhcxatogDCxrmAdjHq5L3kPuZ66asU+nUad7QqtJP/gQijpKgxSJz992q0xgfurajKBJ2C0WUkgF1Nl36ME4KBmRuTy/G4EQf2aJtWLMQYIIBpkheHI+xkTVdH3SA9ktfTWP4CRR8WZdCyVUeBMfwI=
Received: from HE1PR0502CA0006.eurprd05.prod.outlook.com (2603:10a6:3:e3::16)
 by AM0PR05MB6420.eurprd05.prod.outlook.com (2603:10a6:208:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.24; Sun, 12 May
 2019 09:31:43 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by HE1PR0502CA0006.outlook.office365.com
 (2603:10a6:3:e3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Sun, 12 May 2019 09:31:43 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Sun, 12 May 2019 09:31:42 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 12 May 2019 12:31:41
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 12 May 2019 12:31:41 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 12 May 2019 12:31:39
 +0300
Subject: Re: [PATCH 12/25] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <sagi@grimberg.me>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <1557236319-9986-13-git-send-email-maxg@mellanox.com>
 <20190508132211.GI27010@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f2903c05-15f3-9daf-b24c-50f276ff8042@mellanox.com>
Date:   Sun, 12 May 2019 12:31:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508132211.GI27010@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(376002)(346002)(2980300002)(189003)(199004)(126002)(336012)(5660300002)(16576012)(305945005)(6916009)(14444005)(476003)(86362001)(316002)(446003)(6246003)(7736002)(107886003)(2616005)(31696002)(11346002)(2906002)(478600001)(3846002)(6116002)(229853002)(486006)(31686004)(230700001)(65806001)(65956001)(81166006)(70586007)(70206006)(47776003)(65826007)(76176011)(8936002)(356004)(64126003)(8676002)(50466002)(81156014)(2486003)(67846002)(26005)(23676004)(4326008)(106002)(36756003)(16526019)(54906003)(77096007)(186003)(4744005)(58126008)(53546011)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6420;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf6a747-f768-460d-86db-08d6d6bca517
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:AM0PR05MB6420;
X-MS-TrafficTypeDiagnostic: AM0PR05MB6420:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6420D2B7ADE7A8E2F794A207B60E0@AM0PR05MB6420.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0035B15214
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bEtodRr1MPzcp1hlZ4rG4NfOYP0Ioa20FuMEJGqGnmCUkvY3cWuvXxXABKu8HlGRw8e297S+KODVVFie/zHrAquX8sHZuaSCmc2R7w9A3aBe1zno33DkdSjiUh5na51z2WFQ974OoajnPGTLA23fowMRGtS5BkQtaZSlVe36sYi13VLCQSB9cPZoniUYbfa5uvrcD4THXXmjzA8OdOv+cr7HQrOsu/nS/8udWO9BF+mxrnQsBKQwYBoyDBptjHh0reCTG63GDTNNwXr+5fT+CA6lKC/KuRLHSLSzGqQ12xgOXwL5jluSpcSFG4WixJpESQWmTB+32eqCp+u7Svcy6aY638Q5865oQNWj/GUnRyEENH/s3oTullWSLoqo/+2CGMFa20Pf/wmnFqEghZWFV368nqAItI/8Xfy+vPhpG5Q=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2019 09:31:42.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6a747-f768-460d-86db-08d6d6bca517
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6420
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/8/2019 4:22 PM, Christoph Hellwig wrote:
>> @@ -325,20 +296,12 @@ iser_create_fastreg_desc(struct iser_device *device,
>>   	if (!desc)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	ret = iser_alloc_reg_res(device, pd, &desc->rsc, size);
>> +	ret = iser_alloc_reg_res(device, pd, &desc->rsc, size, pi_enable);
>>   	if (ret)
>>   		goto reg_res_alloc_failure;
>>   
>> -	if (pi_enable) {
>> -		ret = iser_alloc_pi_ctx(device, pd, desc, size);
>> -		if (ret)
>> -			goto pi_ctx_alloc_failure;
>> -	}
>> -
> Is there any reason to keep iser_create_fastreg_desc and
> iser_alloc_reg_res separate after this?

Yes, we should merge these functions and also create 
iser_destroy_fastreg_desc instead of iser_free_reg_res + kfree(desc).


