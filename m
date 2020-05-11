Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C41CD991
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKMYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 08:24:21 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:8887
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727913AbgEKMYV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 08:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3gHqk5TftD7N45PN+cI5dt53d8Df4KMBN1xkmqx2fQFkv4XNH1McZQnRYbEqx/+yZUozUE4jr0V2yJs4LlFTSj/NA9yGDs+YOxx6BrKA8RBWBL4pL4GYImFCEWUwqS19mEjy6DXfF1GDZVgtSco+SHSXW93JHv76M9oLX/rNa+QLFL0Sb7rcmPEvv3HlOK3zqcAf+YcjOdYtKaZE6HS016r1SvCcbi/Gsdo3hCoUgJJ2XIbDZk4tOih3Tqzpmuc/g45IGhXEtbcBt2YJD/9Klj209tV0dCUMEGiHDE4XILbL+RRI4KBVMAHOiWKhksbv1aegqIVE3yaZM1cHoGigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mAiV9z1FCk2RVAH2SgRFhzvbGrdiZsaSltBeN/b8Tk=;
 b=lDZWM5GgRpUNlFl6DXaF2NA2pWNIsLXDApyxWXnebeDMIWk2HRYY5k8iakmLyRxvCP7bz4g1/95sgk1WE8X1x2oFiwvnzqyIV9/md+u6xnywa7p8guKl+MpkhhWdwiLB8fyhxQTcL533yJZycLj1lM5ZCT4ucWtsm//Qv8/n48KmHZUsFhBbcCPKJ4dF1cvjlVBz4kAj+Ga/Q7dHVINj6CdfVJfHZncchU484BKGrToYZUoEM9Y9Bcba62UNcBNpXUfkLFjcaqubYSW6ehoRzK5xX8A6WLl7sLrqGXXGoY/7l5kodkOz5YOGENEVUeyV0Fdj1NYTFhbLO4eQ7CNZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mAiV9z1FCk2RVAH2SgRFhzvbGrdiZsaSltBeN/b8Tk=;
 b=gRYC52+nWQkn57g5TyrLWTi9h5Q0rpbfuFfNQSXjCg51qPf0wgKKvZZ38Br/6SIsDhs718Z/In6t5nf8XDbS8v4QOZFFd8yLrL5MzLCSHYz5DH0axOu6WiDZyG+o50YAxYAbERLABwPjA7HqU2fv/ndSkA+ldv4UUwqdjB1u2sU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3947.eurprd05.prod.outlook.com (2603:10a6:8:f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 12:24:15 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 12:24:15 +0000
Subject: Re: [PATCH 0/4] Introducing RDMA shared CQ pool
To:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <d2368586-c10a-8c6a-cf52-57eb05b3f8aa@grimberg.me>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <a0e812bc-9c10-2f2d-ca1e-dbd1094f0a2d@mellanox.com>
Date:   Mon, 11 May 2020 15:24:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <d2368586-c10a-8c6a-cf52-57eb05b3f8aa@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::26) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 12:24:14 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2804d401-9dfa-4d47-50d7-08d7f5a6380f
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3947:|DB3PR0502MB3947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB39470C47770AD2C7B8337813B1A10@DB3PR0502MB3947.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O58J5xGcpzq8OGyxVgFOqTIHxpN4McBARGLPuEK5S0pM3irOuuixCXV4IQVxPnduQoQ3TISs1EJRFRqMrupmZwcJiT1QeaBkeFcuFsX2Wno4Tx56YlbzaXvnehoBX1qN63nFPV+sSDeoQ5reg5H5i2gYi/IdAyXkR6R3wdg4JMZ6gvetNl/edM5aw0girxJC15SjPnfA4AJ5efa+8ztLqPLkeYMa/74v0wlxbOqEZKmveyenBr5RlW9BTQu28M9+r0iKQrnyN+zxG17MoxsQe+34b9QONjvGG+azSuXiBLiv62ihMG5f9aAZVdE545jK/L1eJCKJJk9KHi7TYiogRw51bEEcASoq+f28Ua7RNDVOziei2kDC778FnuNMGzv8NYQQZW5zSLNLQVG1QSo1zxf+WguKAKvQxIy6Ea9hDUpY+CIrVmD+JGR0tOHn+RhD8hW3z5IQ//1BXFMwhvxB7415J/FxZQ53bb/VMxu6FJQH34z9EfZ6KsefF+5V2opazqRbBD9BLHij1Ej/P6xsKHmIT9ztfp8RsLrMTZbfH6i2QNbIV2EQiUsJCRv0gqwp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(33430700001)(8936002)(110136005)(8676002)(52116002)(33440700001)(36756003)(16576012)(5660300002)(316002)(53546011)(186003)(16526019)(26005)(2616005)(956004)(4326008)(31686004)(31696002)(6486002)(478600001)(86362001)(2906002)(66946007)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JbTQcObgv1sjneNMjLlEH8e1m4MioGrMsW23kXYu5jxUvD8SRyGwCT1rl6tP7pPO2nvE+XujAWpvvFVf8Lgkz4fmLCHPonabrfWv0gt2q7/T0XwuHr6F06ZZW1SlLOK8CVpVZHNqvjOsgyk34hQMnJZShStIWO3zLWRbgRkGXIzlODYWyAR4WPJHgMKvJKpMXMD9+yWaG6vg0pqBX3lnLolP/T6gKP5S+KbJ2QdubqD75orKSmJ5wZDwoxmU+PEHzQC+C3eQUdC4xUYbJYijEe92V4QGxM3nIZnsRt2rUSz29BKeBZpEpzE4bn4oaqIoMLQc500Hs5BWA4vW/hRXhOfH/axiRIao5Gwwk2p590QX2QwkpufxMSjCmmqN8lIuEVu1WZCPKaU5VogPR7XAPfOCIbMHwSd3DEnvjBGDq9hysAfzzuFZmQ8YabwaOBKhdzt3JX0DzP+Cqq+D/W4h6sMIhu78YUpYbb3l0qjpKrU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2804d401-9dfa-4d47-50d7-08d7f5a6380f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 12:24:15.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usZKN9AuXEjk5DoUg8N6m7t/hWiJpNP1D4cPoazJ65+L3OUYCywtoI6nvltrcUYhGDsx6ZjoC+36Pfzl/536qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3947
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 11:34 AM, Sagi Grimberg wrote:
> Hey Yamin, thanks for picking it up!
No problem :)
>
>> This is the fourth re-incarnation of the CQ pool patches proposed
>> by Sagi and Christoph. I have started with the patches that Sagi last
>> submitted and built the CQ pool as a new API for acquiring shared CQs.
>
> Can you also enumerate what changed in this version?
Good idea. I will add.
>
>> Our ULPs often want to make smart decisions on completion vector
>> affinitization when using multiple completion queues spread on
>> multiple cpu cores. We can see examples for this in iser, srp, 
>> nvme-rdma.
>
> I'd really like to see some love for the rest of our ulps. I'm not as
> involved as I used to be, but it still annoys me a little. You guys
> sometimes have a bad habit of centering improvements around nvme(t)/rdma
> instead of improving the rest of the kernel consumers. Just one's
> opinion though, so its up to you if you want to take it or not...
You are definitely right I have patches for Iser ready and if this goes 
through I will add any other relevant ULPs.
>
>> This patch set attempts to move this smartness to the rdma core by
>> introducing per-device CQ pools that by definition spread
>> across cpu cores. In addition, we completely make the completion
>> queue allocation transparent to the ULP by adding affinity hints
>> to create_qp which tells the rdma core to select (or allocate)
>> a completion queue that has the needed affinity for it.
>>
>> This API gives us a similar approach to whats used in the networking
>> stack where the device completion queues are hidden from the 
>> application.
>> With the affinitization hints, we also do not compromise performance
>> as the completion queue will be affinitized correctly.
>>
>> One thing that should be noticed is that now different ULPs using this
>> API may share completion queues (given that they use the same polling 
>> context).
>> However, even without this API they share interrupt vectors (and CPUs
>> that are assigned to them). Thus aggregating consumers on less 
>> completion
>> queues will result in better overall completion processing efficiency 
>> per
>> completion event (or interrupt).
>
> Have you experimented this? IIRC that was the main feedback from the
> last version way back. Have you measured the affect of this? It makes
> sense to me that it is beneficial, but probably would be worth to
> measure it.

The main conclusion I have from the tests I have run so far is that this 
is so. This significantly reduces the amount of interrupts in the system 
without hurting the performance of each queue.

>
>> An advantage of this method of using the CQ pool is that changes in 
>> the ULP
>> driver are minimal (around 14 altered lines of code).
>>
>> The patch set convert nvme-rdma and nvmet-rdma to use the new API.
>>
>> Test setup:
>> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
>> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
>> TX-depth = 32. Number of cores refers to the initiator side. Four 
>> disks are
>> accessed from each core.
>
> What does this mean? 4 namepsaces? How does that matter?
Yes, I meant four controllers. I will make that clearer.
>
>> In the current case we have four CQs per core and
>> in the shared case we have a single CQ per core.
>
> This makes me think that the host connected to 4 controllers...
>
>> Until 14 cores there is no
>> significant change in performance and the number of interrupts per 
>> second
>> is less than a million in the current case.
>
> This is interesting, what changes between different cores? I'm assuming
> that a single core with 4 CQs vs. 1 CQ would have shown the difference
> no?
What I saw is that once you reach enough cores working (including a 
higher IOP count) there is a very high number of interrupts in system in 
general. Once the system reaches  about 2M interrupts per second the 
performance goes down significantly which is where we see the value of 
this feature. On a single core we still reduce the number of interrupts 
but the are not a bottleneck at that point.
>
>> ==================================================
>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |2188           |2620          |19.7%      |
>> |-----|---------------|--------------|-----------|
>> |20   |2063           |2308          |11.8%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1933           |2235          |15.6%      |
>> |=================================================
>> |Cores|Current avg lat|Shared avg lat|improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |817us          |683us         |16.4%      |
>> |-----|---------------|--------------|-----------|
>> |20   |1239us         |1108us        |10.6%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1852us         |1601us        |13.5%      |
>> ========================================================
>> |Cores|Current interrupts|Shared interrupts|improvement|
>> |-----|------------------|-----------------|-----------|
>> |14   |2131K/sec         |425K/sec         |80% |
>> |-----|------------------|-----------------|-----------|
>> |20   |2267K/sec         |594K/sec         |73.8% |
>> |-----|------------------|-----------------|-----------|
>> |28   |2370K/sec         |1057K/sec        |55.3% |
>> ====================================================================
>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>> |-----|------------------------|-----------------------|-----------|
>> |14   |85Kus                   |9Kus |88%        |
>> |-----|------------------------|-----------------------|-----------|
>> |20   |6Kus                    |5.3Kus |14.6%      |
>> |-----|------------------------|-----------------------|-----------|
>> |28   |11.6Kus                 |9.5Kus |18%        |
>> |===================================================================
>>
>> Performance improvement with 16 disks (16 CQs per core) is comparable.
>> What we can see is that once we reach a couple million interrupts per
>> second the Intel CPU can no longer sustain line rate and this feature
>> mitigates that effect.
>
> I'm not sure I understand what is the global effect here.
 From what we have seen in various tests is that if there are too many 
interrupts in the system the CPU starts causing backpressure on the PCIe 
preventing DMA.The main goal here is to reduce the number of interrupts.
