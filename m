Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345761DAD0D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 10:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETIPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 04:15:14 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:40320
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbgETIPM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 04:15:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rha7mgaplbDSYdWMPwYFoGzbmmglWljj4ShfmesrCo+MJhz2+Y1BOuudanWTVyfLITqJPJOSi3/0cyxur7gZvqgxbGiTBzSQmqZtM15KZ+1x87pbwsQ3uJtWQCwax3NL6S6I7JY97Ef8eA+DvmDTD1ePFl9sf14zll8Htmn7Couoit+OpVl/mc78fkZBC8ad9CJQSICFTH0tqDSu0Wbwwy6AFoYRqRLi+ZGd81mNBHc1lPZngHt/w5FNSadX424j3/VGKuRHP4+r6TKiC88nPVZiy9+/41UlFVWD+kdXnAXyRkNXJDBHVcvJ2nYygeMGt+6GPAjOVJNBlYT75uAGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMzktuKHmSh/FhBaEm6131xgGRaWBoUoiqZv1peKgjw=;
 b=VWseqmy+OSEuCN10XI41ZhUNYRnqRXvBBp3NQbh2EcC2ACn5o80Dr4fZxtVYVRnQ17MTJDhSCkIeZkEG1ZJ1IzSQecSixWSzWxye0L6/1rCoh/ktwbrVef0RNkJTKrBpk+D6MdSUqZqG/X3D4sopHHA/RFLbaWSSFXEhzhnftCvLJKFra6URbGngypJej8rOv3Eel+jMAiSLmMqR2WjNO3LznMln+/J3k61ipg1T//h+CZJsti238ab90gbwkKrC5M3y6pYHdQo1k+5jH2Pqcrc/rQ4U6QRkq4F6SdDrlf6R5EJcQzYetTopZWfXIHkETonvl0kXLpS6cr9yd4aOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMzktuKHmSh/FhBaEm6131xgGRaWBoUoiqZv1peKgjw=;
 b=qQthweyhTZIPnVEPpYJzL1xbH7AgH8TtE2+lBqZGw3NhE1fK1EILMJKV3Ca7ZazzjtGaU5VmuwFkzdDmuj5cVFOAGcetbkFWSMqGT9GAZVm0MbX/kM2k8EdBd6zreDsjubRbKHpJm8//kWwU6aEXKFjX9Buz/Nq3Gv9+fQooKU4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4009.eurprd05.prod.outlook.com (2603:10a6:8:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:15:09 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:15:09 +0000
Subject: Re: [PATCH V3 0/4] Introducing RDMA shared CQ pool
To:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <c4cf1cd2-e125-705c-24cf-168c36fc3b90@grimberg.me>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <32a26a8a-4dc8-1690-27b1-8c7b3d32d8a1@mellanox.com>
Date:   Wed, 20 May 2020 11:15:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <c4cf1cd2-e125-705c-24cf-168c36fc3b90@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Wed, 20 May 2020 08:15:06 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 609413d5-150f-46c3-7c5f-08d7fc95e952
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4009AF54521314C4A1396AFDB1B60@DB3PR0502MB4009.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLl4KidfaYb+y2BYaMbZ8gSWCok6wmP+bhBwq5xyUVqLWElcl72GX5sQXutu0bQXUG/MswUa9vPTsc5xJY6Se3BtduhQwekE5fNUK8XiB0NqjEQE6MMa9WK3Xkq5t3rTDiO5p/K5MA4dZXJSqXt7rF4WBYQkdCQsScjxnXpT2I3Gj+0V8LO5l+QQYxsdS0z3PtR8Z2VBxw+B2SWw/Xtye4QXuEpQql2Xsp9UWwBtA+gna0wxZqC/fc4fZKXXISV92SZjDqSotXXzZdPYNpFKjxpnQb+wLFkW2u1AeMUsKfA1y6FMBMUZrzNJgKU4lw1UhhJ9UZE+cDb5z/32ZwEKVCABN1AZjIQUVPwfRAycymFLH5QenuDPWAn/wYReFUQvKSdk7dWL7E97AKC6GAQ9IM2updEA09Q/mMfAD8mJaQ8nRIoKK7+A8RGLhbIkVsx/JrU3M11s/UZ4beEq5UYetqVtuLE8AnfPTkv3vBXitOCVLknpeJowqW43Y3GUBfWZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(4326008)(478600001)(66556008)(16576012)(316002)(31696002)(6666004)(956004)(36756003)(66476007)(8936002)(66946007)(6636002)(31686004)(2616005)(6486002)(2906002)(8676002)(186003)(16526019)(53546011)(110136005)(52116002)(26005)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZtNXYaTpNRj9wnoCjO+DnzbSkawnFZzETUrvUuh89Z7L1pcnn3MGhGzEqPesPn367S7iRrVM88fw727T2bvW/ZQLCcngCSAysQLpslt9UIEMrwd9KIxWXIRhU68mXzx7dffNOrE4jrGmC2QBENWo4cgX0hzRCp3hWB96s8p/XQ15CJNYGs3rfkYjHm3LS3L1nlSUSmBaLcv4lACP3EZxxWKkuLnd+eZhcCyJWDlrsp/uSYLelhnEcaf8cmA4ciBLp2MkWrPhZAGavTis50Kr/a04GGLXmrINWNACvPlGWMrFUBlMZCRUReNEjerAUazNle6XiEpTrntwttoJ+73sPiikQVtQ6kYG5wT65cy5VDmEv6gfhkeD3VTirFlYqftCCco+9o86z3xI+dZTXRNlbVSivD0BbM+nt7qtdKk9BOdjqdRTZc+fZTuCChiDIu9bY6Uemtq5HAci/5ytv0Up9u9FgM82SLlkcDZXjsMLCgo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609413d5-150f-46c3-7c5f-08d7fc95e952
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:15:09.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnODNfpQVwA2/UWPj/62xb9CRKFneTz2QPvewqcOlq4si+uO5Q8AgOUjo7HbLGy05LlGxtZLe7UFwYcvilO36A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4009
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/20/2020 10:03 AM, Sagi Grimberg wrote:
>
>> This is the fourth re-incarnation of the CQ pool patches proposed
>> by Sagi and Christoph. I have started with the patches that Sagi last
>> submitted and built the CQ pool as a new API for acquiring shared CQs.
>>
>> The main change from Sagi's last proposal is that I have simplified the
>> method that ULP drivers interact with the CQ pool. Instead of calling
>> ib_alloc_cq they now call ib_cq_pool_get but use the CQ in the same 
>> manner
>> that they did before. This allows for a much easier transition to using
>> shared CQs by the ULP and makes it easier to deal with IB_POLL_DIRECT
>> contexts. Certain types of actions on CQs have been prevented on shared
>> CQs in order to prevent one user from harming another.
>>
>> Our ULPs often want to make smart decisions on completion vector
>> affinitization when using multiple completion queues spread on
>> multiple cpu cores. We can see examples for this in iser, srp, 
>> nvme-rdma.
>
> Yamin, didn't you promise to adjust other ulps as well in the next post?
I was looking to get it accepted first, I did not want to tie acceptance 
of the feature to the use in all the different ulps. I can prepare 
another patch set with other ulps now or later
