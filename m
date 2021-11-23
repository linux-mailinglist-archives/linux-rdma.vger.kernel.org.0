Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EB45AEED
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 23:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhKWWWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 17:22:21 -0500
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com ([40.107.236.94]:28626
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229992AbhKWWWV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 17:22:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prq6sJZhcoEGYn/vMBGPhecBkHtA+3p17yAm3pUA4YkJFpPhMNmyhzmwyIl3U9PMCKCbND0pNHU2z+/VBie6Vbftl8sbwpB1ZlKi3viTFUqW4u3JHo17oah+lAR4EEcrsp9zNfRScHRE5Kuii0+Fo1Es7dby9/5KjV/6BGRWd1L3dWkwTpA6A7gNml4XeL5HFBqu1dhgO5Bv02DC2FXHhcptPo6Za3aZKPUNHNhF/ltPpSmFEvans2Pr3g4iNCgVur7ZCvDN7ICFcJ0Hkm0DMGRHKtzpTEOICSBj+JZv+A+s8B82KgfE6CPc1XpWl7n7vxWvxXrLXrPlwEvBwXOWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mQvQHaB/G6Pb7/Z7zwhBeUeea/1j81vF4+nos+foto=;
 b=fJf1OQlraZxWAB0Hevp2YEtNSxGYDBsEJ59Kw6wP3clUvOpCXWzGy9hQUEWmO5r5lZsNkkleH8U7mg1SLzKr25habWofse2taW7QDVIg1VJgBY5xT+LKrCQ0qBHNBg+rVuNj5Gr3ZF0gf0CYgb9v74rkOcVEFOyDZSnj5Zw8Tr+Sjb6EZD6Quj1vEdwagipghFEYWq/Shvn9Jpd6vatRYI8HKkCeGKDMrOyqRrYbORa4ccVlLDQ/35v12O8vzP0XAMqhat8Obqx/ewiEkGqMC87kxwZZO46V0cZw/JwcB35qA8Loyjitm06PSH4CZ1ct7v+Xifzx2geOjjs9kmX7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mQvQHaB/G6Pb7/Z7zwhBeUeea/1j81vF4+nos+foto=;
 b=KTqIJTurx4S7P1PBYljKf9z5C7X8eEXCwyKbRLZxURosNdOeIXSD7I1KdhSrZZSo/sNNtm1Uix7QHXWviSPUc0Ch0zsMwyR1Hnialgx14qifDrDkOOhGrooJo82YlYCG6zHmjKDeSKArZD1O4MetXqxfOHCwoRWh26Rlr+ww18MADj/P5z6Qvh82KFLjUpo84Ne36WTIYz76tYdexbF4oPVWhcJ7vVLsPI/hl3h9sl2iCxBRlOm//pebgDN/2l1gdfGJUIQZBNA6kGGkD2U42oURZ2Nw99uf1FyE9ne4nnNWRJdrqmwOYmJpzPSmqT3GT1oBzQd6G0ot+zp6iPbbow==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB7473.prod.exchangelabs.com (2603:10b6:510:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Tue, 23 Nov 2021 22:19:09 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7ce8:48b2:18c3:1671]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7ce8:48b2:18c3:1671%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 22:19:09 +0000
Message-ID: <87202f9a-3fe1-dd12-63bb-4f9e8a835a12@cornelisnetworks.com>
Date:   Tue, 23 Nov 2021 17:19:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Content-Language: en-US
To:     linux-rdma@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: NFS problem in 5.16 merge content
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from [192.168.40.173] (24.154.216.5) by BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 22:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdb88ca5-8b7e-454a-f88b-08d9aecf4515
X-MS-TrafficTypeDiagnostic: PH0PR01MB7473:
X-Microsoft-Antispam-PRVS: <PH0PR01MB7473A6370558CD4CFEB1556BF4609@PH0PR01MB7473.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxeJKbSFqwb84g0jbk5wOmYJKwuP2Tvus+nyhKhhoIvzSUZzljWetDjgvLXaYacdM6DEVkUZR4BH/oKxJok4TolcZ7Ctn14ERoHowefcyj20fyw2cZsx41uv9Z/Ety2R4jEyFK1G4MiDahx93kCJMtugJokiZ4Dkk4I+uM/x+B9se7Ikne/ePfjkVAl/Qf7F5v5Uqe1gTx1ha5v5gAsL/F8vrNSeWFzt9aqrbtOgSo2VGCyVWu1CjWDHMeKXKBHkXJ6EpUI/KidYtTC7lAE2k3wQY+beIIgFt4Pbju8iziW7dtny2STxwxdFVgPkxpKWQXv+7L6L73O5lEpmw8hrHZKaQ7DjK+fmc00WvVF4xtvXMHBTy/HgEKXiaByAIF3ELRy0R5LWI4xtrWOt/74aKOMVkbry2kFtGvVfu+qAu0CiyYEhie78Es9JnKnKPPH5Cb0NjkTdo6DzTuKKLFzmMQGL8gF9pKs9fuPZrem3G6Dar3KDbHWYaXecA/ik7qlIVTbzJsMgSPKR27bdN7WKJEi+VJuOAq0E0vdCZD+9fdVg4ySfMUsMEEe1rOYV+ORTbZXxR5lRiygagivyv2G1plOQiYsXYEfGn0RCj8bnf9hwCGdZ6jDSdOeuHmvy7VWighAdNp04+uC769x/gJDf57lQ47I6fgLkdyUVd2Ak1ROnQHRmiWh7GZibJJb2epS1Sxdf4HQHEPzriK0if7xdIRA1InYRY04ul+RcLASbU0hwzdlxl3wIVBQWGVdFBMI93T51nlOR2KzY1ZE999Cu6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(136003)(396003)(376002)(4326008)(31686004)(52116002)(8936002)(86362001)(2906002)(316002)(16576012)(38350700002)(38100700002)(36756003)(186003)(5660300002)(31696002)(6916009)(508600001)(26005)(66556008)(66476007)(6486002)(83380400001)(8676002)(66946007)(956004)(2616005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulk5UXhINGpneG1pL050ZzFjUHRxQ2tuRGoxeG9kb2lFOERtSlZhQ1cwcWgz?=
 =?utf-8?B?dnQzT1VWaUtwUlpoeFovdXNZZW5SRy8zRmlhbWFzOU9ZODBxbzhIYW1xRi9u?=
 =?utf-8?B?M1RNYXMwaWdkR0xBTjhwVFV0WHM3RGFPT1JhTSsyWWo2WHFiOU1jNmJvWE9I?=
 =?utf-8?B?T3NTSVk4cXh0WGNCa3pyQkk1QXlYZjR2ciszSjF2UWMyeWtsM0xxK0h4ODd3?=
 =?utf-8?B?bmVmR1NFZ09VTkpIaURWditDYUh3d0ljR1ZON00zMmxacGZaWUVyUEhrMzFh?=
 =?utf-8?B?TFp3bjEzQUtHSEtUSksvMUl2N2RmcTZhVWttTUJQMzdTcGRMaUJuNXFUNHp2?=
 =?utf-8?B?QXpkVmRPb0phMDROVjhHQlpyTmZKVlk0S0xRWDJWT3BLMkdMVWpac0lYMWY0?=
 =?utf-8?B?OFBsSVBTTXAvdkMybjltSTY1OTVQVkt6OGJsMEhkbmlWRk42R1VaS0M0SGtG?=
 =?utf-8?B?bTBsQ1V4bUtrNlNhNFRpZVNrMDhRbHhRM0tnR21EbzcwTklsNXExdTh4dzVk?=
 =?utf-8?B?T28rK2xKek9xTUI5TkhLTUt2d3ZsNUVLV3hhYTEzSDdWd3MzRnJYdDFTcGgv?=
 =?utf-8?B?eG15L1I3L3JtL1Z3Y3hxbU1NSVJUSXQzMUMveFNLSWxvb2U4M3htMXpIbldz?=
 =?utf-8?B?Y1RvRjRUM2FNUUJGS3JpYlhuSkRQTmpCY3RhalpnNFhncEtEVzYrZFo0cG1o?=
 =?utf-8?B?bXdFejJONkN4RmtFaERvVW1MRlByN0czWVpVQWIvc2dKWm5JcCtVNGhFNHdS?=
 =?utf-8?B?cFlqR2dBS1B5VWhBS3hkcWo5Sk9wSjRWQ1o5ZTBKKytOdWRDYWc2ZEIyOENL?=
 =?utf-8?B?K2E2YmJNaTI1YXRqbVNZYndtWmNvSzNlSXpLcXRvbkQ3ZWJ2UkREMjBML1lV?=
 =?utf-8?B?Y2JMNVV0MktXT3JISWJ5aktuRFZnY0o3RUtEZFAwNmZOK3IyZDU5aDdZMW0v?=
 =?utf-8?B?T3BNMjVSdEd4aDNUOHNzdDBqR3V2eERsYmMvUmozK0hlUzd3dXVyWm9zeThD?=
 =?utf-8?B?UkdPM0c1eGZrd3VjeTlFNTVNdUF1VC94TVc2eWowM2RONDM3aUtYeGdCVCti?=
 =?utf-8?B?cE1aTDFtVFlkM1VkbjQ1d01mYTBRUDc1UEQxeEYyK1VvdjNZNG5lRkh5eGlV?=
 =?utf-8?B?TExMN2JrSnA1VG43cWc5bTZKRm1mMittUUlVU1FkZ281UlhzV3N2QXZIV0JH?=
 =?utf-8?B?V0RScDlYQnZVVHRqWlAzL3hKZ1UyY3NoMy9hVmQ1YW00VlJOMWcyTEQvVjNN?=
 =?utf-8?B?cXExcGZqcTdNVlg1NTlJNkdnbm02SlV4RWVMS2twSTJ5akRwczJ5eDZSdHVK?=
 =?utf-8?B?VGxrbjFObmxVWTkzSG45ek1LeHd1aHV3dFNrNC9nVThPOGZxNTB5UCt3by9Z?=
 =?utf-8?B?aDVvUFhmbllZVkpjcHEwTTlNUWZIakgzTCtCK3E0M1NRV2dHZ00yMHhBdkFZ?=
 =?utf-8?B?NVF2NllqZDhLRGZTenUvVm1BandHQzJaMi9YQS94QnBJSmdIV0ZJdEJnVlNJ?=
 =?utf-8?B?UCs5QjJFQW1hcWZJMmgxTEFyc0VUb1pmSEkydnZoeElUZk5yVXJlalpuWTlk?=
 =?utf-8?B?MlA4c202OW54cW91cGwwMzRRaVo4R01xaTg0VXRlbDFhN01oNS9XVkZ2ZEln?=
 =?utf-8?B?MUJIUFpZOWxhczBJZDNQYTVOcklkbDV4dDB4bXRXZ3VROXMxN2NZQXl1SjNl?=
 =?utf-8?B?QTN2NkZxekxteXhvMTY2NDNsbTRobGUrU00rTzNzUEl2THhoMEdSY1NxbTM4?=
 =?utf-8?B?V2JHYjBpanhFaXhFeE9EUUtmUnRwWiswVGN3MkV1eGFRMFVLdFhpUVkvWWJt?=
 =?utf-8?B?aFk4UXlxT2RSVldOaTg3MUhLeFR5aEJWUndzQm15WmpiVHpPZWExdDNsZ084?=
 =?utf-8?B?ckdWdjRFSzNPVmRJYjR4ZFhvRklqb0ZTSHhCSFZWN2czWU5NeVVnU3IxSDlN?=
 =?utf-8?B?NmZMQkY3RWppMUd3d2VxNHRyZ012MjNaVmdiNGJqQUxLbUlSbzRwUWJSWHVO?=
 =?utf-8?B?cEhjS3FYTzBtOXIrNldSMHA5ZURDRTNjY3BQeGNQelozdHR4aVR4OUhRYkk4?=
 =?utf-8?B?VWlJQzdiQTRnazdIWThyRlFCOTc3Z2doZ3dUZzFRN2tzUHMySG43NlpFL2Vm?=
 =?utf-8?B?ZmwydnBhQlQzSnBUd0J3SWNzVjBaTktLbnNGVE5DL3ptUVRIekp4d2ZUeGNB?=
 =?utf-8?B?OHpPdnlvZDEweTAyVEtoTU4xUWhGR0t2TnE4aGtLY21MMVFOeExUNHBvRHJQ?=
 =?utf-8?B?K01iRjVmcnVBM2lPRy9Wb3lwY0FpK3loakZveG02Rjh0NytMOFYwdm80MVMv?=
 =?utf-8?B?VktKMmR5OGM1ak5MaWtTdXRDWmdxcTFpSWtEZ3BuVGxkSTJqdnpOQT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb88ca5-8b7e-454a-f88b-08d9aecf4515
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 22:19:09.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cQuyLGNtm7oZP3BWTE6umOMFjahjjQV1iKWpzQEQlv2vMbVZbIhUBZsMR5PUsGCZwh5vr/nduJO08PnQBvbkn+4Wc2P9R8O/5yaVoBTfXdCikJbtBnnEg2vkyLvAmyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7473
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seeing NFS RDMA failures after pulling 5.16 content. Does this thing any bells?

[30847.409411] INFO: task kworker/u129:4:797744 blocked for more than 122 seconds.
[30847.417999]       Tainted: G S                5.16.0-rc1+ #1
[30847.424735] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[30847.433914] task:kworker/u129:4  state:D stack:    0 pid:797744 ppid:     2
flags:0x00004000
[30847.443870] Workqueue: rpciod rpc_async_schedule [sunrpc]
[30847.450418] Call Trace:
[30847.453625]  <TASK>
[30847.456388]  __schedule+0x3e3/0x9a0
[30847.460769]  ? _raw_spin_lock_irqsave+0x17/0x40
[30847.466219]  schedule+0x44/0xc0
[30847.470093]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
[30847.476719]  ? init_wait_var_entry+0x50/0x50
[30847.481904]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
[30847.488238]  xprt_release+0x26/0x140 [sunrpc]
[30847.493575]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
[30847.499920]  rpc_release_resources_task+0xe/0x50 [sunrpc]
[30847.506352]  __rpc_execute+0x25d/0x460 [sunrpc]
[30847.511825]  rpc_async_schedule+0x29/0x40 [sunrpc]
[30847.517627]  process_one_work+0x1cb/0x3a0
[30847.522472]  worker_thread+0x30/0x380
[30847.526895]  ? process_one_work+0x3a0/0x3a0
[30847.531896]  kthread+0x167/0x190
[30847.535845]  ? set_kthread_struct+0x40/0x40
[30847.540850]  ret_from_fork+0x22/0x30
[30847.545164]  </TASK>

-Denny
