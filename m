Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68F62279AD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGUHpe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 03:45:34 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:18068
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728053AbgGUHpc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jul 2020 03:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH4r4aiIjtUZTVN3wCAR85JmhzgvHxeKRPv4I6P33gABSgVxmKHFJ6w5mpI9xOdM5PQy/N9bB7xHU8PsdRb+x1x5JnP29cpVptm8d8Fmq9Gx5AgqCakA3ftwV46OYsFq2W4T7/1IqL6hCtGDmPcX977SkQFl1PVRif2zlrcOhnWkwbek5sxPTpu6I3jqtGKdHuDfiQwQRfCh2ysQOG1PoCiariCONc95ryg8h/5prkibj9Q0IV5fO43Y3R47qFRHRR8XeUCo8aqB3N4RI3GXaSKWkBuCVNifyEXYSayl4fvEKMy4mr3bJMzubPfwJETtzvLEJ/2fhJ08H4zxd8XoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUWqYWXjGZ5OdnuqsTdsz2ev0WdISQZDr42VloR8yTg=;
 b=BBjk7K4eNb5Xo8gOipIrLOEQq9ZPr5fNd9H3rz6kG6++6EBa73Eue8YOTXQFyGNeC1CMxPePxv0AHja76vkvb39x5Mmn3AopIQIQQI+Tgz1O7VgruMA6Wgc5G/8/4cASHzsmJS9YZoZr1a7ohkYKJ5xfDS/SsWpRWMS4QEDkQb8H4qTrU4osXtFMvqSyHz0TND4sul3nCYn5ZPfsK8HRvNa6HN0XTomnrfuyahSsFa6Ql/o8PDVdorb9TakdvDF2vQk3riZwYjcuFB3ZNSgF6D2GUweAwjbZFNuTxgxlE9lpW7sTSexXZCsGrCg0UPbiV7nXOSiZgptzIvGF7wPLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUWqYWXjGZ5OdnuqsTdsz2ev0WdISQZDr42VloR8yTg=;
 b=c+dtzQWRT44Rk4LpECCKHIfnAqFBH7IxBMsj6AHLd+byUq4V74rkvMnkOhwUp0Y1GF+wJZ7A9jcDoF+SvqmwGgQbbw+kwsQZNbyNbijlE4hG86imHv00B666Qd4PBgwnN22bVe/YdJvl2/iDPSQIU7gjMW2oAoV4tdjp7/iZoas=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 07:45:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 07:45:08 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
Date:   Tue, 21 Jul 2020 09:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200721074157.GB3278063@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:208:14::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Tue, 21 Jul 2020 07:45:05 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22de25be-7bf2-498f-4608-08d82d49fd49
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB393545FF5A8E570BA46DC7B783780@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrltq7Ly72C8i0bovbe0zZUFMP4Tfdyg2RsSqDceZyLsfPKvUdY6pJf2iCAn+Y74/qZfsTc63IlsEP0GB2fkQdizlCINvrm+yi9db1h/nlM605u0+xap/qweIh+oaoV90CTHBRsWZJLc29brjhhWt6CGYWnPYKJHf7si8R5Y+Wznyaiwha5OFuGuUjrVjknAmY98KFbZDjCAreeF4dRM1CCZPBGilHWxBS/4ZCky81aVaaH2fC+5nuq5vbhikKf/1KF5vysF5+ea7La7y9HL3P9SRBpEG5t0CfMexq0K4oYqGBvVjCGQgHMgoAWCVimLuQKCuCGGXNC7DLut3ZNeTU8iNf+JUofesjhgcaIiIa61Z0ZXsEHM0RcPZyT9dZwh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(5660300002)(8676002)(52116002)(53546011)(6486002)(8936002)(86362001)(478600001)(7416002)(31696002)(6666004)(316002)(110136005)(186003)(4326008)(54906003)(66946007)(66556008)(31686004)(2616005)(66476007)(16526019)(36756003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cxZHbExQQhGeLFZVzw/wzeeLojbqJpl1tA5DhMdFLoATBRaxTd7i467dORphz1si3INLY7Yx7SmBBjzovaEq/tFAQHcBnBduoPSdytdogLcb+INCJbHvNuQlC4lKO0YU9DxOzVsH+bLFLowRcf7XuXBDZzNwA2mm1fv+X8XsobWs3V73rP6tmeKEiIbnLU9BTGrMcG5tWfhFivveJHxnYIqn5I/Q+20cHNHF0bYhtnL4mDG28Ln7yYCtXNvP3HvLd2riyGUTuSKsxZ3I2P4wXdHN+KBPMBdV/hi6UzMXgaF7iZF4Tejkjpl7IPOc/54ZvZQv8TPZL9S/JrK/dy05mU41QIk17c1OnbYIkXTfThZ4ORB4phuomRN0GMuwHFtcjJ8+JMcdgN2CPesyR004E25Fs5Gsa0wBf8jpJR6XH4vNoNIvtoEKy9QmY/XwWEvId0s7Hx3UnNfpCTHndSgdNTCoGpdS3xEC0vUpZT/2hVKunIoWYqjQ28Ko03eOTvCQ8siizE4fUNoqi0udpqpmfVx1BLYZsg5JxpR/3eisG3AcrFZL41Q/K964cbZm9Yap
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22de25be-7bf2-498f-4608-08d82d49fd49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 07:45:08.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ThKWsuBaLokNtiT4Q6yFfZqYtxeKlxVTVLiWK1NUTsK51epKUjyyPcvIY910y5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel) wrote:
>> Hi,
>>
>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>> write this down once and for all.
>>>
>>> What I'm not sure about is whether the text should be more explicit in
>>> flat out mandating the amdkfd eviction fences for long running compute
>>> workloads or workloads where userspace fencing is allowed.
>> Although (in my humble opinion) it might be possible to completely untangle
>> kernel-introduced fences for resource management and dma-fences used for
>> completion- and dependency tracking and lift a lot of restrictions for the
>> dma-fences, including prohibiting infinite ones, I think this makes sense
>> describing the current state.
> Yeah I think a future patch needs to type up how we want to make that
> happen (for some cross driver consistency) and what needs to be
> considered. Some of the necessary parts are already there (with like the
> preemption fences amdkfd has as an example), but I think some clear docs
> on what's required from both hw, drivers and userspace would be really
> good.

I'm currently writing that up, but probably still need a few days for this.

Christian.

>> Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>
> Thanks for taking a look, first 3 patches here with annotations and docs
> merged to drm-misc-next. I'll ask Maarten/Dave whether another pull is ok
> for 5.9 so that everyone can use this asap.
> -Daniel

