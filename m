Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4564434B020
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 21:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZUYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 16:24:39 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:21121
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229957AbhCZUYM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 16:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBvtyRv52XDmmCyPGOtf9s7fuub992IA5R6csL7o4pPm+1HQe28+dvyo4LQlsNm0h1jFHsqFLUTfofwcaoK1c2++vF+Naduisl34Sezq3+lPScMjVyFsdFQxhV7RunE814dOQjNJuo5vKHs9YfxqiBerWn3af05oyIQdKqQVUHbW/LDRTSKCpaLgYb2715xcnxlZ/U9/u2mMjV0moCxaNZwS7D84jdHYDRvZUN/fpm3/qFe04O+StBxSeRKb1m/glLJ4AYkxnE7Bsw+aPCZZcswTQAitD05IJxiuIku6QotJcBWtytA08uLYpygorXSLk1AKKEJQvlcEmGBRIEQQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIwtrLu39wSj6ZwLBcaR/BWAcovuI5kbhCD1iRPOyRQ=;
 b=aa9m26HZjE5hgDDUyDAt7ZWI5Inxj+ccMrS7neXJ21joePsL/ypLd5J9Zv77AJk6FDs5ZwCxWzdf+BszGl8t2kKgzhGyOei0688/JWnIwo0Gw1UCXteXPV1jTGzwC5KHZ4hZF03ctosWMw/flYfdT7pQTV97c8YPkx8461jxB+45fgBid1Aa3Uf4JHWCRn2QkmPqcoJhAc4Pk/Ud/GePjccL9IKMm47UXSVQKkgWyRb/SkeEvUNKVjR6EqZwo1HQooHLuYaxPcEIeOyrZGJkvI8L5I4AUMSQpKST/Ls9IQ9K2TBudaj87ZZVuNh96e5PFoep3kQyz83ygPagY0zAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIwtrLu39wSj6ZwLBcaR/BWAcovuI5kbhCD1iRPOyRQ=;
 b=CbPM9h+0+r493lXG9TejC4ev5t7092+q3rJQpTloXyGqmYmegcrEqVAtNKV28USOcH5jWjuLUUHCkzGs1WG0QFe1ypMOBvPk2Ntfvs+w9hM7/66SreVOdTM/3BQ0MKTkvUqKISTvFb1Pui8hAGjKwaaRP985MmYWyrygM5l91mNacwjBoIc2V+jsEluCgJUerdM30/AcYJE0AswOULc9+LFFEGQavtsVEtFwuQGt33u3XRcGcOm/VO+eCl1XXiJpeBA8Fzj5YcDPBTbB6vs/ZQuchMR2K7zFrSzRLFeFYkw+kPgyY9L0dmQuCz8aEfpno5A3PviphMpInAX6nctLkg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 20:24:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 20:24:09 +0000
Date:   Fri, 26 Mar 2021 17:24:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/6] IB/cm: Remove "mad_agent" parameter of
 ib_cancel_mad
Message-ID: <20210326202407.GA938816@nvidia.com>
References: <20210318100309.670344-1-leon@kernel.org>
 <20210318100309.670344-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318100309.670344-3-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 20:24:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPt03-003wFQ-6P; Fri, 26 Mar 2021 17:24:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f168a166-c011-49ae-f1bc-08d8f0951c1f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02031BDD141A77117CF02706C2619@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Hhc+d1D9UnE5pA1RCvH1A3tWmqCB7165JwHU2uPMcE/Bd8b/sgR1COcc3MtWxVran9IQLJhSsq2RexkXsybcnHX3CMkvIlRILJ6sRimG3eK3Ofe/TyQ3NqIShucA4gjqrBTQftVrYYazoRKDL7t5VauB/+XH9Sx1sfpjpAA73Tq+UYKu6n4QgTHwDQV/fuLorLRVSUFAm+yOmxSgMdl0+2ofWZA2VuELmNJvAll5BpzDF+PWWx2zUqDMfMbbw8xeA9SQN2aXHJiaCNuZV5utKGvW9O9XC2vzkwoZu2xHSXun1yI/6AOgqqMJlFotdvLh+LrFYBCiSlKbESasf7r17/s+dclzlbmTW5wP4uvgIDETL+QpV1sGPkUTLiRQxXEhArspK/bobM3O3GaMSkbFNxIA7/c0IHQTfoik7GcIhc8zSv16dK9JS2Xstxkene8JcibMCwac0E6ykbWXT7/W5erEMaBo7jGN2k+yOkCZtMVZDo56KO4eZoGdnJa+x5v/WFCzgOT11XvsNMdyUgzNrLSz8+4Inb20ODoMS20Ivwg9k+lRQtoEuJlDsrtdkU/UMYnE02tAoo9Ye4/TiJcmdNbRZPcwYD9fSkdbweCPcGEhg2gHiyfVbqkZTcwFyUhFP8mhGpjnKaDbaXunyqDYD9k03nyvINIl3JwCQdjhIgSiCLCRKJigezJvQMKdiEA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(9746002)(8936002)(6916009)(9786002)(4326008)(86362001)(186003)(8676002)(54906003)(66556008)(66946007)(36756003)(26005)(66476007)(33656002)(4744005)(2906002)(5660300002)(38100700001)(1076003)(426003)(478600001)(2616005)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?92zS74VVUFonuEXxcEpjjCdfo2TzYHbd5vJpgeQl9hn5EmlBXUr4zZa51o/v?=
 =?us-ascii?Q?nMUelmiwMUnMWaFoMYP4YCJSBEprbePLv0yhC57o7j5GkUJdNHscWvlFYCog?=
 =?us-ascii?Q?JedeyTx+Wql3Yt4q4222fLSlaPr0jNeqg3KcQs6sRgFpBm/iTGYWLGjT1zok?=
 =?us-ascii?Q?m3nezLZzJyFWr1sgAZtxY7N09I3f9SswjhMPPRYxd44OjhyjdPhVdcmhFQ50?=
 =?us-ascii?Q?Jv+jlkhgl3vt4eF2NP6cbUGOcSQGMQot4Xe0dS08EaQo3rfP40QOhpxUI3QD?=
 =?us-ascii?Q?F0usz/GqNieeVvK4Vv6C8P1hGAwwT6Us1qvsKvKaD3xi7ua3Om8gfcxqqKwy?=
 =?us-ascii?Q?UZWuhoiyjjY0JiCOaKxpkjMaGx26AEgAhI0m2fD7qMxDyStVvNm0fGBwy7eX?=
 =?us-ascii?Q?Rk03aKc1M2o/48+SdjibBtPAAU2pPNtN7dygb1yv960K/ooeL9fQXaCcAdZ+?=
 =?us-ascii?Q?4Ea8TUQxNjn0Ak6bGiiw9oTr/LPXPyLvzfj9qau784APIXDBaoqmZhLOCWEo?=
 =?us-ascii?Q?kzph2WG++ZJQ1wgtZJPxwW1me3tmDV+BUqct5Dlgz5G0ohu+euIhERwbVAKi?=
 =?us-ascii?Q?RHbyMdRSonBo6HwQpibNyjRId1t9XhSbrykdSo2HerfT//udqrcnur+GMg7C?=
 =?us-ascii?Q?+T0Xw/2/KNFoJ7eashzw+DPqZHc99zHo6GsA1mXMIk985BSA4MuJKUJ/Oy1m?=
 =?us-ascii?Q?WAKOxB2542yRshf1XxQgIwrBVK6vKfLJsOrBPUrCcVWDnZIphzq8SmkT92Sv?=
 =?us-ascii?Q?p72Rr3JrtdqFDoqk44Y4plBQczvC2fxJnaAiqdnmvAVG6y+IMSwktQ0AAlOB?=
 =?us-ascii?Q?8zK41Qn7lcBEnoPBVMRq/Y5bwnTcPh80fMBVC6NjDA6FAMi1LqCVchjdvTsR?=
 =?us-ascii?Q?yxUFzbDbp03/yqTKJPdnq0wgWjxy/hS3uQ0916MheVaI0yRZCt2uDn/kDItN?=
 =?us-ascii?Q?FeDlVFKt1CM9tzXeIBybi5dgZzXtw55q8g6FyJHhL5pX1L4veRwfhS7y8L7M?=
 =?us-ascii?Q?WNJD/4tESKV2sXfGCdvR4T1pxtFMgusLwc/yvaZobBngQWZOJY55C5DQ47K3?=
 =?us-ascii?Q?OoEHjGM0Vadn3wk7Lp+hY1PhZFEFkMq0xmHy1azXcIXZtAnGlpEQH4nRKoKW?=
 =?us-ascii?Q?BkVpfTvsGQXlZBQephtXUTvpj+1C0qheCXZoe/O0EJL/FiUNg5n1fiGPVlAn?=
 =?us-ascii?Q?Sr24z0Xz02x3r+AN5aF7bN4TvkRQbMM/v69szw170K1xGvc677DP1lVt1ajT?=
 =?us-ascii?Q?OP+LMP4hBI6xKbO3/RoOUIXnM6GWD5XxK6XXGzx5GNGcbanQY56kSoPt4yag?=
 =?us-ascii?Q?XsWl1E4Awy4YM95sXJcYhX/DYhITxq2HypjqJl0BpReh6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f168a166-c011-49ae-f1bc-08d8f0951c1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 20:24:08.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dudLaU69d3VJt2TQsk7wn4xe+1JYisgWL9Q5+mUIWdI2NH5gZG2DHA7ch7v8+P1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 12:03:05PM +0200, Leon Romanovsky wrote:

> +/**
> + * ib_cancel_mad - Cancels an outstanding send MAD operation.
> + * @send_buf: Indicates the MAD to cancel.
> + *
> + * MADs will be returned to the user through the corresponding
> + * ib_mad_send_handler.
> + */
> +static inline void ib_cancel_mad(struct ib_mad_send_buf *send_buf)
> +{
> +	ib_modify_mad(send_buf->mad_agent, send_buf, 0);

This needs to check for a NULL send_buf, most of the calls are just
blindly passing cm_priv_id->msg which can become NULL in a racey way
in a few places.

Jason
