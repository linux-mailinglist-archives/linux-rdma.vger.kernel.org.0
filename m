Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1A6408A3
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLBOnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiLBOnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 09:43:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112888C683
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 06:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I05vYs62dU7RD+S+bTPTYpM1beo9892zpqL1aARrP7MZ3CXQEz0OWm1eJNk6m+G+xTcOwvXyhqL8rvLnHbiwQWXY8EWZnlEFOQd/+bHzN09WT7ikYARG0C4OQ/8b/SFvjr+AwfwmRVk/+fPukXBqYZOzSf5BWRzDXZa16PDCWGg67GsHsyTMm8qShg3ClxTXvt3yAQoCMBdOtV7rh+YiSgtrBh+kmZmBE2oarqRKN9/XKsXsnboz1iCjgJXL6GP4htW2g7awyjYqAQY0t+3DBA9yHRQAVMeS109BZ4FYa+4aYEhCPd/QZfmTzeSW8+DwCPTiMk2F02Xjb1PuWaTnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri7nK+wnh6DZcT7xMMHcgQteBkZHJW9ZHzBI5Q+2KvE=;
 b=QkpIoKPI7dhrtkoRP0gL5RUMA6wIOecnhsWZT845uW3MzCR9YVMvkPSRY9FwCfFG+i+zY2Fdzs0KGScc5XXt80HzNWMZBTriW917yV+mgE9wd6dimnKiKwHrfPn83ynxWXWhBXkklblTkzPPNSHBjzHSpVVwNRB7KMbAXFB46lnjhIM3vTljoXwmhOImIq6P2ZpXnM6Wi1rHPixoOwRZXknFUgZ2tjqDaxD1SHhbfXonEIl0amb798teKJ87jl0k+viNB3rKn+Vnppd7/XPP/j/8NWlUEZd+7gSqFeXNYkze4CU4OWdLdA0UmxlC7MlPLd2Mko+8B8q3HcbNTdVJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri7nK+wnh6DZcT7xMMHcgQteBkZHJW9ZHzBI5Q+2KvE=;
 b=bEvScKEz3kQhDlCpluq5r6eOvg3h+zrWGTFWb0iwQKATYo5erBCYixb0eMbGQvxxsYwskt1wd+IGOzDiAqVOzPidYVexujgoI1dZwhYz1NKRle8Qjefz/VChBZS/LxDlfwl8mEcbPSj2zrHoGkBTwIU/hN0X4gJhx9TROG7vDbldY7/p3iNm3E4bDtrgUNaW7hulHmxlaPlrZAw1ljHWLMuJowvO/Wq33khTVu0NhtYTZbGFJnMIchbVJfogu58zWBhoSvksaqHTrRyXKKePdhW5EioL90dnqFNDPJ9HOtOsOR53CM8L7Fl6EMB+XbG7VzRDwlvAJOfUfl1WU9qFKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 14:43:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 14:43:21 +0000
Date:   Fri, 2 Dec 2022 10:43:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Message-ID: <Y4oPCJKPdB2wSDxi@nvidia.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
 <CAD=hENcdfWQd5ZiN0_sc-Jy5tCj2SzdBpyGNYuTwsWBTqq9Xjg@mail.gmail.com>
 <a1df668e-eba3-6b48-4ec4-d4aefee19db1@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1df668e-eba3-6b48-4ec4-d4aefee19db1@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b2e66e-9829-44de-222a-08dad4738f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXbhS/cxfgePYOwvyV9uoEzfsdy26s11RQaKEEwqth8OcRKOkVgiVfOrpMa5rGDFxBqO0376DXRO3lesVyGZQpHefCjb8tifOp1x3DEEoiys7FVJwkNZcAWuDF4Wy/zZ8oO4Wn5oHk8alFJv+rmyKg7faPxgXL5SLFh6kMdlJw5QrNYIh1/P6lX0BqFAUxxTUg+FHasi9QBmKWqcPR/R8Bx8REG6NgJYMiy7APwpaPvyMqi4X+hKh773RqNUohj4iJe1Rmzgz2tbwzlyEgyv5mBcDrvMkWXskJ6ZsxkH2GuS4qtTOrKr7FQ5Qf9s8VRTDKihonARl6Nn65fO1YwZavkjssvOmdKWryKgDwZq85GTVcBJD1HRFu/Kqxu5wH1mB7iluKFu4HZf7cxvM0Ou0I6p1r0S7S3x5tzlTjxwWpFFAcNKPzKA7qPeB2bXFkZki5js9xtW20V1grC0np9ECz63cMC65KhDu8mwwyecvtV7+K5nhLCTxwSyJ0Q/bWrRQRNTCq0dnUU5nzIYFBIUP0xcFmhx3vzMZ030xCwuRDoJC9QzjC3mpFPiKFaP6ptArqUspmrx+5SaXwHtRoiVrCIwdcp+/+GVCa5dm0PesH5pojR9kwvhTyMrc6+b0sCy8srZZFSsGS2uGIo8RjAXlqqGdcWHYDhrj5/0HnLyalfMwbPe+ucMGN9EIeBVJFIOwVieT1fV0l8rXKiFlELBoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(38100700002)(6506007)(86362001)(53546011)(6916009)(2906002)(54906003)(8936002)(6512007)(316002)(26005)(186003)(36756003)(41300700001)(4326008)(8676002)(966005)(66946007)(66476007)(6486002)(66556008)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBA9eFgTRAuVUi8A3lVa1cX0yL/WncUzROqi4e7hJGnw6bpK67l/ragCM+U3?=
 =?us-ascii?Q?9r3sorAMzw3SvZnAirbV+xxEUvz9kpD8Hx39Z4brFw09ZshsNcrCqOs3XAvo?=
 =?us-ascii?Q?zqN986xAEB9kcT5Gr+BUzQ9FwAaz187D5quEapd24VewMJJuIAXIamXzX1Xx?=
 =?us-ascii?Q?G4M8AkEV896fS77w4N95aB9XOJWluxd8aBJB/8DOqs4GSPno9Dlr6CERxEf+?=
 =?us-ascii?Q?tp3uKiW+206NaW3sF3HLYe3D1bOaerEK6NofG0C4Je+V/K7GmhqqKIcYKZY9?=
 =?us-ascii?Q?W8DQhlQT6EIprEKCQwcLAZ/jqbOVeuoFAMR/HEuTDjjZ1wjnHlOKspmBjZCs?=
 =?us-ascii?Q?5mRsWS54vWLruE6f8QotK/CNicjaPxEE/8zlFCFyh6w8lBRw+BoIeCGjVMrq?=
 =?us-ascii?Q?DedAPTZp8R/xbUwN2g55EB9jnuPqKWY0wanq6Ts9PEIV5UH9IhoEeRN1SOvB?=
 =?us-ascii?Q?wBAyzfxE8Ogp8Of6XBcmElGFI0ou0TnREMAABhYdKFO+swZvtQCUlkXHGHjs?=
 =?us-ascii?Q?4bb1VGNBESd3rkmxEaOySpTqNixGuVJSS4SMzMLPIY6+CARnf98T+vLfwol8?=
 =?us-ascii?Q?31uoQrktfV0SOeEIMkskbIj2U4Wlmc5H9XCFFF9I54/21Ax5HqMbdfX3e/ZW?=
 =?us-ascii?Q?EfiU3gxjiS7enhejKeitcLlKsg3fjiwDZ2lt2mZKLPAyLA5OdI2jOoZLLk3m?=
 =?us-ascii?Q?otcsA87SVmd9V6/xcxCCCPk4DsWSG/uKX+2WROy8oPPeIkktJchyzXg+QL7d?=
 =?us-ascii?Q?+mJe/vQm1uu4ts58Liyjr5LRZ3FMQdqXuhX7Z3fQfdI0C8lBQ0MOHqqlk7Am?=
 =?us-ascii?Q?CZj8tZyi0rTDM1D1+IwB0VsCh2T0WBwAoflR8sBKuiWxRAEKSjqyTWoyA35h?=
 =?us-ascii?Q?lvTdlNUrclMJnSl7TXAC39DnI3SnykJjA0s1HdVVoJBVhZXZYrOWvwB6LrpE?=
 =?us-ascii?Q?0an+HlVbmMbRrORq6Qys8O8x4msE+T4ZxSHpRlQqE1oklgVaqnEPHRDYHHoH?=
 =?us-ascii?Q?HzIUes8CAOAEf6ulyqsapP++UiCQDa8zENopEDI8up3GYzwF1s/j2ijEKuJV?=
 =?us-ascii?Q?lbSdJ3ubfO2WJuoAtAELMAcnWOGpIECnu7tDUAdOtpAooJlDxX6+ZXXdu4oe?=
 =?us-ascii?Q?MnooVeTJlRC3zGbS7VS68g8xu0m/6YJm1kJYKM1x4nFe59S5esNxkja4foRD?=
 =?us-ascii?Q?HHAeM2OG48veMnzIGKmfAt25jPSdcNS3YOvZ1J1/aBGgUP4+ZafRuDe0v3mT?=
 =?us-ascii?Q?iurDc1S/LwXEmzeatT+gQB1x5ZpKHxTNOUywb7H3cxtPKdpLtQhkEFkxfK0n?=
 =?us-ascii?Q?9YYCYpvCE4wiFegCFMO2k9kJEeFZI6/M2EKMpej1xr2ObjpL6QEkxpvx+g05?=
 =?us-ascii?Q?NIMvSmwxy41ntcOm13Ss09/2zoPclB+dxoUIJr1OXDUFZsz2EQtVVlZuQNdP?=
 =?us-ascii?Q?VriDRLNBjXBfu0g5Ax1Trn5XxDz03AH4c0mWryrMCQj5sDG/tFpFsPJ4CAjD?=
 =?us-ascii?Q?uKACkY2QhqDfHWzqucjHoNSKN9iN/6UX/g8XbV13zXL9RIhiUMWD1g8rlS4F?=
 =?us-ascii?Q?m+Ra7uBDFB8zSBvjsrw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b2e66e-9829-44de-222a-08dad4738f30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 14:43:21.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEGTh5Jnyvco7+kAkcKA7PKjpVl2unulILS3/b5wUhieZ9wHpXGS8DtQif36I386
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 02, 2022 at 02:35:01PM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> on 12/2/2022 7:45 PM, Zhu Yanjun wrote:
> > On Fri, Dec 2, 2022 at 7:02 PM Daisuke Matsuda
> > <matsuda-daisuke@fujitsu.com> wrote:
> >>
> >> The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
> >> a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
> >> is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
> >> dereference occurs as shown below.
> >>
> >> [  139.607580] BUG: kernel NULL pointer dereference, address: 0000000000000010
> >> [  139.609169] #PF: supervisor write access in kernel mode
> >> [  139.610314] #PF: error_code(0x0002) - not-present page
> >> [  139.611434] PGD 0 P4D 0
> >> [  139.612031] Oops: 0002 [#1] PREEMPT SMP PTI
> >> [  139.612975] CPU: 2 PID: 3622 Comm: python3 Kdump: loaded Not tainted 6.1.0-rc3+ #34
> >> [  139.614465] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> >> [  139.616142] RIP: 0010:__rxe_put+0xc/0x60 [rdma_rxe]
> >> [  139.617065] Code: cc cc cc 31 f6 e8 64 36 1b d3 41 b8 01 00 00 00 44 89 c0 c3 cc cc cc cc 41 89 c0 eb c1 90 0f 1f 44 00 00 41 54 b8 ff ff ff ff <f0> 0f c1 47 10 83 f8 01 74 11 45 31 e4 85 c0 7e 20 44 89 e0 41 5c
> >> [  139.620451] RSP: 0018:ffffb27bc012ce78 EFLAGS: 00010246
> >> [  139.621413] RAX: 00000000ffffffff RBX: ffff9790857b0580 RCX: 0000000000000000
> >> [  139.622718] RDX: ffff979080fe145a RSI: 000055560e3e0000 RDI: 0000000000000000
> >> [  139.624025] RBP: ffff97909c7dd800 R08: 0000000000000001 R09: e7ce43d97f7bed0f
> >> [  139.625328] R10: ffff97908b29c300 R11: 0000000000000000 R12: 0000000000000000
> >> [  139.626632] R13: 0000000000000000 R14: ffff97908b29c300 R15: 0000000000000000
> >> [  139.627941] FS:  00007f276f7bd740(0000) GS:ffff9792b5c80000(0000) knlGS:0000000000000000
> >> [  139.629418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [  139.630480] CR2: 0000000000000010 CR3: 0000000114230002 CR4: 0000000000060ee0
> >> [  139.631805] Call Trace:
> >> [  139.632288]  <IRQ>
> >> [  139.632688]  read_reply+0xda/0x310 [rdma_rxe]
> >> [  139.633515]  rxe_responder+0x82d/0xe50 [rdma_rxe]
> >> [  139.634398]  do_task+0x84/0x170 [rdma_rxe]
> >> [  139.635187]  tasklet_action_common.constprop.0+0xa7/0x120
> >> [  139.636189]  __do_softirq+0xcb/0x2ac
> >> [  139.636877]  do_softirq+0x63/0x90
> >> [  139.637505]  </IRQ>
> >>
> >> Link: https://lore.kernel.org/lkml/1666582315-2-1-git-send-email-lizhijian@fujitsu.com/
> >> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> 
> Good catch, want to know what workload you are running.
> I have never got it in pyverbs tests.
> 
> Add a TODOs: add pyverbs test to cover this scenario.

Yes please

Jason
