Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7821B56C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJMsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 08:48:31 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:41123
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgGJMsa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 08:48:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMe00wgYIVWL1yQqW4IwyAlAkxXE5rvcWiOuAhbaoinN1jGAjN0FKg3grUI5zHlI/2sfi27M87U2qDU19VNf1YKLh0K97TBuri+ut1+qwgnxZ7oQpPlUQ9FqJimhl5zcvZHBNOkSq20Xs3gFuVKk9b1V32eudPLiVj00jPoxWkotfB216oqKZurOf2zJRa2hB0S4TpkaaBrPOMRMZciKO76j/b19vFupM8m2wmgYFLG1r6kS3dwh67kHiuqcBwMUtg2OmGCzopKb7DjF1/UE2y5L8HiOg62UrTwkEjtvDQ1ZimzNM5mElNTvdfKdls/gOVNyIOEIE+e6cX346DGzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRicB8lZ1n4CdHhITb96a5QFslM4iFA5zwyqjj+2yzU=;
 b=b8epVAx3kCJZTNvRQCR+IVai3xLpi8EKcyXCejtt6pmwKqHQqX7ufQGPHmQA8G1HBmO/ZPxZwAqpFwrza0U3MuxuwUPcqaSfF3PUfZdNPpdAGMeb4JTcnlTNMmZczpeF5D6kx0X9beBOhHpXodBMqa1JuEhZFERKPzwnrSoByIomLTd0RIAOu4Tr9mDEAyTH0JG+PKc1tNVd96pVumotx21p1fIU85pBdzi3+Ihfy5LB3TQGNHzyyPUMYpsUJhqnZyKoBUwy4F3yQnD2W6YZvkkWa5YbqBzlg5SPIIuVzEjQpHNIb6s7QJTcPn/aYGqwqq0tWjBE5NbpLr4gVMCHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRicB8lZ1n4CdHhITb96a5QFslM4iFA5zwyqjj+2yzU=;
 b=bIqUod6o+/xz84wXP+T2e8RaKdbwGbJlnENs6WOsxeheeOGCvBPVp+oPhiHXomLXRhjDrI5280rTM9l2x5Gph5yVVyDh/LB2tdIaNtlMUCtD7nTsmn2cuivf5uLnxaanuY3f2EJBTA0nsA0i3ffjhJMATABFVXdzw6KWZ1Ma9mY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 12:48:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 12:48:26 +0000
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
To:     Jason Gunthorpe <jgg@mellanox.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
 <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
Date:   Fri, 10 Jul 2020 14:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200710124357.GB23821@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0101CA0055.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 12:48:24 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a56712a-98a8-4fa3-261e-08d824cf89b7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37890632022C22A1D00CA93983650@MN2PR12MB3789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Admx3Qc0YUOjd9BXj83AJX2YrHB7gmdv1ZL5EVBcsQ914EwX5T9Spv/DQNatq9T45O4Zu1oaJbywJ1ihLsNmPYSf5CScspew4GGlU5RNHuVQSb96rltw85qC7ye3gXklJQizxFjPonHRgK7LRsPJXG8990/qEiqystFvjk7Hpy0xb7gpKXsk+VRTlvmNoBun+U1v9IvmdfcIorh+VHgzfTJJVcWP5/TP/7v+ZwfrhHJrK08lAAoATJcZvPZ4b2A4U0bgfEk5Dfl4mB2w2rpuy5THRHCt6CGvp0rn1QW4CmKgBSe8l5n0Id0347PY+/7yd/nIx2Uv9o8YoMDqn/KOMWtIGdb+FHiXky75yiosElwCtddBJ4aLnvtz7sayX6jS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(4326008)(31696002)(2906002)(86362001)(6666004)(31686004)(16526019)(66556008)(66946007)(66476007)(5660300002)(478600001)(6486002)(54906003)(316002)(36756003)(110136005)(2616005)(8936002)(186003)(8676002)(7416002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1PLgswyH2pJ2LHY/OAygHHMiMjadCG1fpyo3aU5a1kr/w6SIpftzu2Ej3pIfckLuCqMtLUb+aUiZiw06ALFKdIIn0vSFoDKo8Ya9fXmM+ulAcTD/2OP6Oap7/Gbi3rdm1CT0rnTVpUDj9FRenNwf0K93HQ1coztV2Bd7kNMJrrskhOTzY+1yuaOVuNwhVJiU2JHqPPq2UiR5ij/SRIw/Q9pYibTv1aze18IHjgyOLkaTHdPsy+yxy8iSdxVt2K6JooX8h7pM5Xg7WO9Zrfsj0ACj5DwzoYH7N06lhCMaxF7WWo7mRe5WAVpP41279uBXRBtkxCPyaOwqTMaOd9zBMFTZkSEWIM0ggRLnulzazEpmo4d+hdtcJ7OP07rryYDtm5MP/BSaDYytouw6A+wlBj9RsbY4+rIfi6O8sG77n4X9GbgJiTPHX+MbL56Gvv+S4YcEdJUxQWjgs9BJ51doC8RRAWUcbCDlB65zNOQyeTqFgj+UwmomTvE9ca6gmiDWo8+p0ptJJNzYgwwovoqzHOx7nphhMXs4Jr1hfW31TQi3MOxaFMJX91aIw996CxBX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a56712a-98a8-4fa3-261e-08d824cf89b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 12:48:26.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytZHHd+DaFbvU50GSN8wPdq/wMh8tp45OOBW9aBG7DvfkbGa5T2gnfrJgAc89npI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 10.07.20 um 14:43 schrieb Jason Gunthorpe:
> On Thu, Jul 09, 2020 at 10:09:11AM +0200, Daniel Vetter wrote:
>> Hi Jason,
>>
>> Below the paragraph I've added after our discussions around dma-fences
>> outside of drivers/gpu. Good enough for an ack on this, or want something
>> changed?
>>
>> Thanks, Daniel
>>
>>> + * Note that only GPU drivers have a reasonable excuse for both requiring
>>> + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
>>> + * track asynchronous compute work using &dma_fence. No driver outside of
>>> + * drivers/gpu should ever call dma_fence_wait() in such contexts.
> I was hoping we'd get to 'no driver outside GPU should even use
> dma_fence()'

My last status was that V4L could come use dma_fences as well.

I'm not 100% sure, but wouldn't MMU notifier + dma_fence be a valid use 
case for things like custom FPGA interfaces as well?

> Is that not reasonable?
>
> When your annotations once anything uses dma_fence it has to assume
> the worst cases, right?

Well a defensive approach is usually the best idea, yes.

Christian.

>
> Jason

