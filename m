Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388E83428E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFDJDL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 05:03:11 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:54245
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbfFDJDK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 05:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMLez829qPFhPhTKcYRQDzcgP/rOsTg/K2/czeva5gM=;
 b=RY/igOCFzZqmKpv5CnNBNtOlY0OYTG5eKEn6r+B9Q52QDn+BVfJ3pSSDjiFR/MwpcT+sIW/23YEsfALGwvMgp7OaJAqtU7W/D55Xg1NA0l7CpswLCrQpkuhB9Ydno93cE/A+ZI73zNMmcz03b7yj+21Ow4Uq2TwFp0DpMYnD7xc=
Received: from AM0PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:208:55::45)
 by HE1PR0502MB3020.eurprd05.prod.outlook.com (2603:10a6:3:db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Tue, 4 Jun
 2019 09:03:06 +0000
Received: from AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM0PR05CA0032.outlook.office365.com
 (2603:10a6:208:55::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17 via Frontend
 Transport; Tue, 4 Jun 2019 09:03:05 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT044.mail.protection.outlook.com (10.152.17.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1943.19 via Frontend Transport; Tue, 4 Jun 2019 09:03:04 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 4 Jun 2019 12:03:02
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 4 Jun 2019 12:03:02 +0300
Received: from [172.16.0.17] (172.16.0.17) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 4 Jun 2019 12:02:59
 +0300
Subject: Re: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-4-git-send-email-maxg@mellanox.com>
 <20190604073514.GL15680@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bcd4fe8a-38df-e302-b12f-4e7a99f9a77b@mellanox.com>
Date:   Tue, 4 Jun 2019 12:02:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604073514.GL15680@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.17]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(65806001)(86362001)(7736002)(36756003)(31696002)(5660300002)(47776003)(508600001)(8676002)(305945005)(81166006)(81156014)(65956001)(26005)(8936002)(31686004)(230700001)(229853002)(64126003)(356004)(2906002)(4744005)(3846002)(4326008)(6116002)(65826007)(50466002)(336012)(77096007)(6916009)(186003)(16526019)(446003)(53546011)(107886003)(106002)(6246003)(2616005)(486006)(11346002)(476003)(126002)(54906003)(70586007)(70206006)(67846002)(16576012)(316002)(58126008)(76176011)(23676004)(2486003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3020;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1bae3c5-efd7-41d8-7539-08d6e8cb74d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR0502MB3020;
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3020:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB30204AEBDF73F9531C6BEA40B6150@HE1PR0502MB3020.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4cttSwXUGPIi7WhD7ENDb7Tfk8ni5/jI1RFkFtF7M7fhQwGBUg2r4gRb6k69TFxaYLSjEf8gUbNFTv4hY3+N7dRbQssdgZ1WmQ1e3YkgNp1NMNb8z9QL7fOfzf1a4xcarjKQmf9hymt4d9I5SoQsf/mo6uM/r5BWwa5/O31cnS38w78hRz3PTUxaHuI4lgWXbpGkf2q+U4rTL2XAXfmStlNYPt7uG/6bJlOqteenoedSzf68BnLYisH9jujubJrp0hfyPxetm625CM0fi8+bV2glgAFWZ3ADJb3+jhuL3l1mCsRZv5mIoXcDCnTH9DwkaxGDuxnM6XqlOdmm4QjZvMQNnPjyfuek5AqvsyPr3CXuCwchVuIMsH75xU/sd1OuYc/MzLf3xjrObUU3iGz5bHUp+w4yspR5oF88OGF0AAw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 09:03:04.4029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bae3c5-efd7-41d8-7539-08d6e8cb74d2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3020
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2019 10:35 AM, Christoph Hellwig wrote:
> On Thu, May 30, 2019 at 04:25:14PM +0300, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> This is a preparation for signature verbs API re-design. In the new
>> design a single MR with IB_MR_TYPE_INTEGRITY type will be used to perform
>> the needed mapping for data integrity operations.
>>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Looks good, but thinks like this that are very Linux specific really
> should be EXPORT_SYMBOL_GPL.

Well we used the convention of other exported functions in this .h file.

If the maintainers are not against that, we can fix it.

Jason/Leon/Doug ?


>
> Otherwise:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
