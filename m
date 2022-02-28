Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1474C776F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiB1SUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiB1SUD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 13:20:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B407541A8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdrX2szVEu//N7lzS7P2OWXIGBVq9rFhmAODKfsLQ0W0EXfb+JQi38KaMPKiZ/BlwOKIY/DYaMo1VVBwjvXoE7AtjIYV54Ez4cZKDhRMtA8U3LQMXi7GbiP1kXi2BQFlsgBf8UNb1Um7J1JnNlrpgJf10dljBO2wj6LWnS37DyQlRxVTOukuDn2dUFWQlWuF3emPHg9QhK+IlzH1xBwGoPiiO5DbCgmxpHFkg8yLatxinWODvVFffP1IQ59qQMfxgysEMjhe5wPOVEf2Uy8RNG2VBLi9E1ck5cmln7v2yc3ZzsdGfabvXz2N7QGuL+rL5t84EpPUaZ5V+5A50yu1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8scTjUZVCrZGkK8fI/mtzzD1TMv3dh8pnCyNgl42aQ=;
 b=XtUjqeFlXkqhTOYIwVbs4EgYRIVWS0vHIE2OMtVgbJggino9pSQAvgMCLRNgGJFCgSLWGK3ADiblQWgLzjC15aM5H+UmSZDGklmPKxewlnvapmoMknEMaxQwomQRkq+UWQ38+tqqnaVbW9KOEmG4SrWhiTBHb4+vcR6RnKUB3o8+g4ThN4JMUM5JHdxORDBsMKZbOXaZKi+danD3MUzfptnmcSQWv0NNnk0PMHmFVCkHxq/zzz/3nxkk4TGLk0at/6mrF19gg3v6fI1l4i19Lwz8IqcvX+XWMYpiKBeVfVujQXQZ0VeDLFMGttKqomL+NiN4yAebETi3aADS7VhilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8scTjUZVCrZGkK8fI/mtzzD1TMv3dh8pnCyNgl42aQ=;
 b=uY3SGhhZUo8oxZODN5P2IkY+ueWAHUYUpnvgHQ57cTD23uQOCEqHipYWnujUbWO7KGkFt96yI0++DoTYud8stoOzX2snOOYoWCkA4PkH55gGTSstjxrJbM3KVbzChIN4YsDd2QKX8YbMgmkMMtQKyLoF1V+tGY1wHrRnm4bcxYddeihBniQT5vepXniLJTFpimVeI5gDA1DxkaOSJIDiG9Kti4XavJKzoKbT1XWUye0iO688BqtVCsAX66zlAZUe5BKBGYXV9xciXBq3Jmrh6ZJq3/GdbMBnTXI8yvKsrczq00pZrHJSKPZj9ylp/Z2pjaIpLYftm1S24Wu1cEomRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 17:56:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:56:20 +0000
Date:   Mon, 28 Feb 2022 13:56:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robert Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v10 04/11] RDMA/rxe: Replace red-black trees by
 xarrays
Message-ID: <20220228175619.GN219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-5-rpearsonhpe@gmail.com>
 <20220228165731.GI219866@nvidia.com>
 <CAFc_bgasCdwwb6C79cwsHVPv5tw+Sk+vJfe38M0OGbzCaMhv+Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFc_bgasCdwwb6C79cwsHVPv5tw+Sk+vJfe38M0OGbzCaMhv+Q@mail.gmail.com>
X-ClientProxiedBy: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75262ff1-2f19-44b1-94e9-08d9fae3a078
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5153751DD09AD515311FBD7EC2019@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vu2WqZHvGoBO95wMfAk9OT4gPZW8S/iZ2Q4H5UzLSj18SV0hiyfRhesyWtsJoBktYqAVu6UfwtHeNUPoybBpS/r4tb4WbaWVjKlaMSQrVeZx/unt695mjjb9nF9xrd+Opsb7fMH2O5JOjc31VuzQrLzHn43XZwk7T+PpsyxJO5nKDYr+6pAzyI1wn+F2qbjlADRsB69ok3fj1YLPsBXY205EGIkMGSucdNn+CrOLJFDakQ649AHXqIrzhOKX/Eu7hnuKn7JtLSzn5bZgbauAAcF/Gn4u6UogPUfVzhv3ts1AmzILzDIxF0+8tYs/2lZVwQ6LGoS7rXvDs+8/HNYE0N5unUtVI62LKadeSBompsRpUbVKjxtx+Xlgo35Lg/ntqI35nmmk3a/TsuR2f0371ttVmfw5iZnygaMLvasLP7+pATGea+lfR9A11CCdnONQfDSSz9J5e4gMH0aPqR3L/Fv9LGCD/JHaa8un+DmuvM/HT908lJtEgRRadzLu2AFfA/GRoK99L9jEq1yHq1aJjHrHYuBKdoOnIXanVePG/+tP2taNZmFKyTqPU4IoGdPDG2+aJzRMyCD8V8zTAAR7/s+bMapkDDYdO1shQm9AnD3GwwChFwGLHXWQRVrvsqhgOZOOGuQobvfZWEKios5P9QEgeHggnXmenO2rQHLkt3oCVwOQTUIBK/Do9pV0H6SYlPj87C/5x1UHWfzVrT+EwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(83380400001)(86362001)(6916009)(66476007)(33656002)(6506007)(316002)(508600001)(6486002)(1076003)(186003)(26005)(2616005)(6512007)(8936002)(2906002)(36756003)(38100700002)(5660300002)(4326008)(8676002)(66556008)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kRIxYxMHjq0ZzKbyvoLZTXam0OmJgjYSldV0DZNKR0LDhLJKVGBjlqBS1Z2?=
 =?us-ascii?Q?gqfJX13OTc09gwB60YH061oSe+5FFwbjvqFeM2WnrQu0Hl2MI002aBmtaF4N?=
 =?us-ascii?Q?QBWuB5dFEUBYV096t+fFsKYj7pJUtuxTzOW7ifv9ydbiTDF+HL/8jiMlz6Zl?=
 =?us-ascii?Q?KTf9Fej4joBu2HaE6g+QsSjfpDNV4Aw5n+ji2NIwVvMqGVQkNE2E+ehDblpy?=
 =?us-ascii?Q?VdVENOkd704BCJK84V/jc/MF0eTz7j/TdQvA3uqEUkMBBmooRavVXa1zZ8wq?=
 =?us-ascii?Q?pICaf47EGbqIrP8OMe1O4kt12HwzOYP+lFE7DNXPkFaBafdqPnkJXfq0fLSs?=
 =?us-ascii?Q?GskMEYoqjD9YaDLrtZPeg1eSLPTkjR6cWZ13G3MtwxOOdiVIch8ix1OwyEle?=
 =?us-ascii?Q?UOszPP+Ie2rwvmMkqsFaZ7t6bPoZ4kkr/kKuc2kUu8whicT0Ltm4AGrtBRTE?=
 =?us-ascii?Q?pAWykQoDyWajGLN7WCLpzFGDTXVgSN+oVtKLVZNGfOSrv/bCo7APMcUmjwNU?=
 =?us-ascii?Q?/lVga3HLhLmrSKc3PRIUl8TUtdFtNKDKP7T3Fl5ePqx7GMLcB91ff0Q51JHe?=
 =?us-ascii?Q?5CQbpEiCL/4sQdUMtThdBPX2A/XeR62zKyEVfRJIkZkJqDkd+sYrU11ACrGS?=
 =?us-ascii?Q?03Hpcdqyf2x/j5dXh/+nIAdgP50VgpyAfRmrJjiTq3oB4PJLL3hjJ0atInXy?=
 =?us-ascii?Q?Dio1n2SvDdwLG3lQ//EIR+AawvZ4O9BzlWKUU8Ouknvej/e81Dmd5aPRGU+T?=
 =?us-ascii?Q?STirJr/lX1OzZCa6lcDQgjsepGz3zh18PSB/rC9Zl4D9SQVsfd8CSDrAvgSO?=
 =?us-ascii?Q?jkepbVm0dicZOweZmnvE4eY4IZIrzyVT1TGP5IqmOcGW/2AUbyeCjrRZM+oc?=
 =?us-ascii?Q?SkShgG42BoIHpD5ej+0IQGKSEH2nAUASNzjwGjkxB6vvuL7cVwbGa6I1Le4f?=
 =?us-ascii?Q?7fsr9IRCFSBnM/ArcfLsr51xVOPDyGBROi+2/j+UgTecFqYIZoQ7JPZoJJOQ?=
 =?us-ascii?Q?joqhsl+wtxuUdBO+VrcY+xhbwAU5IPCNXIgTEF226kI973gH9PwvcsbLR42a?=
 =?us-ascii?Q?0Jr6eDaG/q9JS2f+2bCBLZ/V55bEHkuqSy8Qzl//1ZGUGbsW+XaKRdXS4zLA?=
 =?us-ascii?Q?GX20mwNmxqPdfpk/gKJvY0uRHMHfplNLIq0WHof2HLygbaciS4tge5UnHgWq?=
 =?us-ascii?Q?unt70SvrSm9eO7pqgVHM+P2+svAg7nvDdu8YXPUmEV1duoJkVzWEDKzv2/aT?=
 =?us-ascii?Q?Ly0jJPjIGZ82sTm0heKY+zW7a/cwDX7F9ePJh9wm4hxkYmoIgOibvi9bgrz2?=
 =?us-ascii?Q?6XOJOSLS2G3DDegZrWWQ4dpcBTx4pseBCSIaEepzpHQ+OPRfDIys0M8QpwC6?=
 =?us-ascii?Q?nL2SiFNmCM4/UIkzucMmZ93MbZ8OprxXKdzfzy/yJMG5B7zpT1lFZFiTQosA?=
 =?us-ascii?Q?bnrs+1snbnAPU1ujmn/ZlKlm2vcmY+4+yuSY4p/JXcoWxqEHjfnPXd+cx3tK?=
 =?us-ascii?Q?hyNJhM4wJSFZunSWKwP5wGZ9gFUqFuiAzbZow/qgqqHeOiTBV5BRmqpfVQEm?=
 =?us-ascii?Q?LRoGVchgJX17pdI6Prw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75262ff1-2f19-44b1-94e9-08d9fae3a078
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:56:20.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wrh9YVj2E3568lCm4tHq10buC87GBUwstP8Wojr095XUMCPhgO6+08P86KyHOIje
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 28, 2022 at 11:28:44AM -0600, Robert Pearson wrote:
> There is a xa_lock_irqsave()/ublock_irqrestore but I actually need
> some things that they don't support.
> In particular there is not an option to call xa_alloc_cyclic_irqsave

Well, yes, there is actually good reason for this. The lock/unlock
scheme that the allocating xarray functions use can't be trivially
nested like this.

When, and only when, you need to allocate the non-blocking AH you
should use this pattern

xa_lock_irqsave(..)
__xa_alloc_cyclic_reserve(..., GFP_ATOMIC);
xa_lock_irq_restore(..)

Everything else should use a simple _irq (is this even needed?)
variant without nesting under another spinlock

> and I also need an irqsave version of kref_put_lock and had to code
> one which calls the refcount version but again that takes the
> address of a lock and not an xarray. All this is because rdmacm is
> crazy and makes verbs api calls with spinlocks held.

You shouldn't need kref_put_lock at all. It isn't really a kref, just
use a normal refcount and trigger the completion when it reaches
0. Nothing fancy required.

Jason
