Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19098342A7
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfFDJHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 05:07:00 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:47489
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfFDJG7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 05:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBSSBQyX8XoP0Gm1MQcmRpknXkhMQTPWf8XX5Bc8LNI=;
 b=ZzwMITm/9xXQ5HMW0zrfx7hW4Wo/qZ6OYDiy+T1dwGsIVYfuWIG/ini/1GsKTS2KBQCIzGDWqEX5FfxZ/zcAyLa0Om03lJYfINmkzra5Q0qcvtgV87RAfb+dZxkTiTuLPTJGj5YKCZn6FVlhVIsRA07/gRRWgDAms1ZABMuMO0k=
Received: from HE1PR05CA0234.eurprd05.prod.outlook.com (2603:10a6:3:fa::34) by
 HE1PR0502MB3018.eurprd05.prod.outlook.com (2603:10a6:3:d8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 09:06:55 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR05CA0234.outlook.office365.com
 (2603:10a6:3:fa::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17 via Frontend
 Transport; Tue, 4 Jun 2019 09:06:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1943.19 via Frontend Transport; Tue, 4 Jun 2019 09:06:54 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 4 Jun 2019 12:06:54
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 4 Jun 2019 12:06:54 +0300
Received: from [172.16.0.17] (172.16.0.17) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 4 Jun 2019 12:06:31
 +0300
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
 <20190604074858.GR15680@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f271d27c-2f69-bfdb-9dee-eec32eedc463@mellanox.com>
Date:   Tue, 4 Jun 2019 12:06:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604074858.GR15680@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.17]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(189003)(70586007)(8676002)(476003)(486006)(186003)(50466002)(6246003)(47776003)(26005)(77096007)(2616005)(305945005)(106002)(126002)(7736002)(65826007)(2906002)(23676004)(64126003)(446003)(3846002)(6916009)(16526019)(54906003)(6116002)(58126008)(70206006)(4326008)(230700001)(65956001)(31696002)(11346002)(107886003)(508600001)(53546011)(8936002)(336012)(356004)(31686004)(5660300002)(2486003)(86362001)(16576012)(76176011)(229853002)(4744005)(67846002)(65806001)(81156014)(316002)(81166006)(36756003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3018;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e3b0672-57b6-4558-ccf8-08d6e8cbfdc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR0502MB3018;
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3018:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB3018873DDAF91625D151DB7CB6150@HE1PR0502MB3018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Fyh0iYY9rBszUJV+H4ZejvfiOlYgQv15voYO5iFO+yUPDAyJkqqYP9AF+kxM5C8fIgisxXNddr34wBNjS/A/Ye1gpDnoddKvgdkm42ptHFhYLnEzhKTKElbwER4aO5iv7xyZ+Y21s7CWfgOcZ6PaBUyCR0CCkYhx86SjJlE7c7QBvjy6Hy/aPfAYHb2nIex2JMfpsvZ3ytvfZCTVNjGf6h+K06b5k/eY3eN413S56T1fd5d4/FoaMr+7WLNBEKS7CNaT2CeRGbFfOWfTbHBXCqZMBMPSQNwo7ErxudYnY14N7mthDLW8KAPuTli/BrolUUCyO/aSWgbZ6aUQWwWXmvaJNvGQothAZdTv7QMXQpb/BJpkzvBWWTlSD9zf2YErXYV84peK2QxqJfva+afXAGym6LURF7+CCdJDNkcYKTE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 09:06:54.9643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3b0672-57b6-4558-ccf8-08d6e8cbfdc1
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3018
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2019 10:48 AM, Christoph Hellwig wrote:
> On Thu, May 30, 2019 at 04:25:26PM +0300, Max Gurtovoy wrote:
>> Protect the case that a ULP tries to allocate a QP with signature
>> enabled flag while the LLD doesn't support this feature.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Oh, ok.  I think this should be folded into the previous patch.

I'm fine with this squash.

>
>> +	if ((qp_init_attr->rwq_ind_tbl &&
>> +	     (qp_init_attr->recv_cq ||
>> +	      qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>> +	      qp_init_attr->cap.max_recv_sge)) ||
>> +	    ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
>> +	     !(device->attrs.device_cap_flags & IB_DEVICE_SIGNATURE_HANDOVER)))
>>   		return ERR_PTR(-EINVAL);
> This looks almost unreadable.   Just make the signature check a separate
> conditional.

Yup we'll fix that.


