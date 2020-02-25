Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0159916BBF0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBYIgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 03:36:10 -0500
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:6831
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgBYIgK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 03:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC0O7tVXgluQYlkyKWzz7qLsaAEdWaMaCHhWzIVog447iaRTM6L5C2BGa6xJoY1PRtM94inBaW1sNGzYcHVNP95JhYgjZYArXmlBiLrJeRzPn7sPicOaPQhCUcQ8VUOZ7up2fa21uTk67T5mzv5MTWWTA1MbfCKcmKi3KwntdcsLDDjkfbdaKSKLZN6bZvMd9NKAqSKvZ39liEv2lvIPN90pfe+eZWrOE47zVse9w1bRvVIKGgsMl9V9GwDMgiaEGy1/+SU/CS4KRoM5Hxk+CftxFttKCDkRfbHty2SEWL5qQzRYU/UEAdeOWmf5aTKDZSIXJdov4PDr6atMSlkXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ozzqsAsCqr6+aouuThyBOst6bg07pwc6rDOyULzPzY=;
 b=lT9vfpnmnNa1W7JgVly0D38j+mDN4X+UyefkjZRSKuJzxtna61OdxReWlYB9AvqOhqbF3xAVyA40dpjvXDg/Vabi8ev0fski5lvLpD+9c2q5CzYY3DaaqmcOGn5EXYtcRnNQx/23fQGXiz1DZ95aDoKyRcvZR3MSeDSd8MBNihQERCprK2AEtPRXf4BmbxHi6XjIVUp6eUaZfBzLWz1n1GMuAmxQV7PianaR14e6LWosT7hcZ+O4SIRt/2RJWoq1cvAJ+oVxH9PKySUe1R8MKYi+j9mIUEYvWEx8hC5TeseD/bGMJwkk+cYR0XLva5kLqI/kRRDIhSOKgn9CiKE/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ozzqsAsCqr6+aouuThyBOst6bg07pwc6rDOyULzPzY=;
 b=ivAKPabP0dw/Xk3juXkxA+OGyqNne/yXWjzUowwIEs6zuEqS6F9n5a09e86fBwRNVJWYHwS8EN6NsMIB4VYC9MtEPuSrWUTvIo5K88w387j9WBrctSDRIa5uDL4C6sVZjBNxGKCazOioguc/1WtuuJ2ofF4j5kjHjjVuUpA+v9U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=haimbo@mellanox.com; 
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com (10.170.246.152) by
 HE1PR05MB3467.eurprd05.prod.outlook.com (10.170.247.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 08:36:07 +0000
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f]) by HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 08:36:07 +0000
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
From:   Haim Boozaglo <haimbo@mellanox.com>
Message-ID: <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
Date:   Tue, 25 Feb 2020 10:36:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200225074815.GB5347@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::36) To HE1PR05MB3259.eurprd05.prod.outlook.com
 (2603:10a6:7:2e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.0.75] (193.47.165.251) by AM0PR01CA0131.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 08:36:06 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc3c2dcc-b8f7-4933-a1a2-08d7b9cdc223
X-MS-TrafficTypeDiagnostic: HE1PR05MB3467:
X-Microsoft-Antispam-PRVS: <HE1PR05MB3467763FF6B4E70D6DFB3705A5ED0@HE1PR05MB3467.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(2906002)(6916009)(86362001)(31696002)(4326008)(16576012)(36756003)(186003)(16526019)(53546011)(26005)(81166006)(8676002)(81156014)(478600001)(8936002)(31686004)(66476007)(66946007)(6486002)(956004)(2616005)(52116002)(66556008)(5660300002)(4744005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3467;H:HE1PR05MB3259.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+nruXebJcGtF/c+giZYFMwjnr3sbNcNhn+SDMSsnDmhU2Rx0fGTaxpoe53mw+MjXlfgnWxclh+Nw1sO5cPpqSnbfV6Pj5zwLkZGmVlYyB5oZYslSFp1Li044b1eqoqqOwdq6jTBejsJj3CcEE7sp1uoAqxDywB8QasgWahuUGXXJY7zlfZKnF4AsJ2TebDOT73gTdD/l6DQmUlOUR3MZFw3B/+rrgkHwB3kL9dZ1M18gGRLEEv6HhoWWWeO/TiK5jcNcOUSLOIut5VCr9hBY9Dsp9YmRu/PYbfUVyPudBoLKCWG3KXfPWU+4SlvyH5PyT1dvl0tjJ4OfqTLWYvyM0gbD35YJho/tGifoBKyJCwXkb+3C5bH+HmCWPRmhtpxJm24kMkmi9c515ITaaZkRVmtOK+pNOcIHTnN0x3cl5c/8Y8iA4jAqMBBz3UaoHgJ
X-MS-Exchange-AntiSpam-MessageData: sF5xnUckAsllfpZ2rlBEKK7bHpJSpBCkDd1Zl/FwrKumpysKH8KnMROrca+GMb0tupIeX4eBnO5FQ+UHkk9RdE2XLFYEqLuqUOJAtuZiwuIh7VmIaWNhs575pzvMF42xx0fX4sIkONiNNlALu/FEXA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3c2dcc-b8f7-4933-a1a2-08d7b9cdc223
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 08:36:07.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj+Hu0ChZ1A5ry2WuoI3IwGvk543EDbP7dNO6rywWjVTjUESa2Pl+OI5e4l9V+Cq0pLJDrMlBN3+k4UUc1hO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3467
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/25/2020 9:48 AM, Leon Romanovsky wrote:
> On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
>> Hi all,
>>
>> When running "ibstat" or "ibstat -l", the output of CA device list
>> is displayed in an unsorted order.
>>
>> Before pull request #561, ibstat displayed the CA device list sorted in
>> alphabetical order.
>>
>> The problem is that users expect to have the output sorted in alphabetical
>> order and now they get it not as expected (in an unsorted order).
> 
> Do we have anything written in official man pages about this expectation?
> I don't think so, there is nothing "to fix".
> 
> Thanks
> 
>>
>> Best Regards,
>> Haim Boozaglo.

Ok, but for many years people got used to getting sorted output in 
alphabetical order and now they don't get it.
