Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF134B6F34
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiBOOmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 09:42:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiBOOmN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 09:42:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D9CDF97
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 06:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEFmFDBGck21IED7cfihJG71sHQtJ/tlgM1lMLoPtsT/UG2NLpRaz2ei/i96IxdsFaST0L+1mHyeuo9HvTSLDg24PIN/hB8KQZyl96eoPsYCQPTxWITsEJxBhKTbrH0Ww82gVLTAxa3xEN5PrBCQzcz+W64wozBeez27xAkB2OYmn7O7p29wPdF4ODQ2Ltv0aPsGajSV7yFrrd5N2Y94DFGVGL2ouRDAixeOzUkB3KKmURfPoIQcUGBRS4hoB9ZE7szN5T0r74P+EHOW/JGdgNX6Cuzm70pVq8koRnqTbDiwjcqtWgmr/FnX3hXQA5HRfX41DL5yc69YMEJCYWQ7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yvv+05wDH6QYTodMDCdNbe2pj1kBJHi4+B2+oBpI98=;
 b=RPwycHUOb/T7m5HsfJ2ifJqJpAIymQyuZQiS0J3WhCuUC2gqMXKGv/bS3EP6bFAoYNuJUfB1cUzyn6nmo6VsOErnY21qyfBGnRZQYo2gyax1nlruj7AwgicrBfps+vlFZKYJSP/I4z5nDiLIb4jCTG4Lx1/LEy7sLw8XeC6Gur1psCyuff1TsLR4XlcOgSUpiZTpyiOQj/gI6KAblDd7RP0bpQcqcigMg+9FfszPnkyyYrWKnNdutb6bO/qlpypncjTrikOMEZEWv4iI+iAGEdWaGtsdlG52Gy9yNrynrdPzMJm9uyRfhC9ElO66NKDNreHGGv8h8PU/M0gmcxqo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yvv+05wDH6QYTodMDCdNbe2pj1kBJHi4+B2+oBpI98=;
 b=MpMetp7gGci16ADktiEvsq1T6GwPmMgNgosL0R1/SQl2CfyzaW8RtivjkZKH1USYLZ+03ItG8ir3VjmhxA+bIx47o+XAdZ/6JAYkQfl7i5hekrAshieudfZzG9goUs47wcN1PRJiXp2SPdTvXrdgJP2xp6aq6+KiOlk8EnXNJYoobu9NYH9+fBjE4itwr0oKey1BkaRFP6yAFLdwIRGC9gBJnxvmT8S7zW9fM4wEtI6WBOGVDbMwWb54n2h4MVOUtKUodDrGBVgKWEamIZXhQVhM4attiL1Z9yHKrvvvkPzdpXQoFRgzjNtVo84WDDMsaCVVQJSaLYI9itQwFPMcFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 14:42:02 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:02 +0000
Date:   Tue, 15 Feb 2022 10:41:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Message-ID: <20220215144159.GQ4160@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cfc2006-bd20-43f1-8f71-08d9f09153db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058A35323F457E59D5F59D0C2349@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DpCqKny4j/fHv2b0ttk6F9coB5lgu7zL2yI87//IiT7sbKeo/weEVOtuFndlb5MZ9c1Byyh8X2lNTSg1wZTqqoykPME2r0ALagBy0b7/9SubO1AN5Cp4ZkovgipQZ0Anc1yqXWtIYvVRfHmBKr42dYHDBRrfzEXouF4jltNRfQUZRxy4fO8alYOTomKnnaMByP1/lORanbPMSy4HpTimEy79IZQfPp1ECj99pIg6oODx6nj6wMQyzjQW00Ju0qhrxynWkbO4rc5tuVdn0vwUHX/RE6oq9UfFd3I2XwfvE1g9sEI/QzPfjAXOFV2zSRnMi/PjF8K4O79+lczGQ+XsLF5zqpERrzjBrN+KD2ngAlJnCVTk5nKuviWKQdojLvbaMXDfJi3295dBzxEyTadKwuemU96lQ+bEB3p6g84f7d+uwo9k6peBqLiUNvQVGrFgf8CczA95kRLtRb1wflnHXK04Sqe0zDacRfSfyf9y2p5ikCPmKoLpVGx4niNKbMjz1YsplDod6iTQmJZL0QtuNeVhPD9mCyzMvDBeH3uVcOHEK5PL7JD5Y0eh09x1s63r1vt226HUtOMKcSHBn4KZfFBJoPPSeoU2QpvIfSf5R5kfTmIm+63f7q+iCXPbiwk4+4JpSz3AO/Cwv1OT+BN6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(508600001)(83380400001)(8676002)(86362001)(6486002)(36756003)(4326008)(66476007)(38100700002)(54906003)(8936002)(316002)(186003)(26005)(4744005)(6916009)(1076003)(33656002)(2616005)(2906002)(6666004)(5660300002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FhYYWFk3a8u8vjFDDZwc2qJ9vAHHxxic6e1Se7DuMRPqCRPX4hLWAz4KNKdD?=
 =?us-ascii?Q?+/mhKmv006FBZCCUJ6VmbYu61IS1XYyVP0IGaM15MpdEefHzkJe8S1dH5w5y?=
 =?us-ascii?Q?TMEGVP8Fz3632jQRi4ozgkdTYVBfrV/V/4hiWiwhDBCU6AM8kLsmntb+n+9F?=
 =?us-ascii?Q?zdCaOUtq3l+oToRrzW64jIIFWQhQwjogi2N7Zwe+U2M8ghXGqAhGf4WI5qjt?=
 =?us-ascii?Q?BEltbGpZriV+VIWlNjgZZTD2LEOTU7nfJ9OceHjGJn1w0gZJafocofczXaJd?=
 =?us-ascii?Q?kYh157MiIYCqq0+bBtC3AikC66A0ufDAZwvE+Wmd9P3lYxN2PItvTvttFHeZ?=
 =?us-ascii?Q?jQLzxXS2eK45jJ7AvcuFLOd2Rqo+chIKHxtad+KCn8/ImjAd6kQTBQdXwj5U?=
 =?us-ascii?Q?yHI5fGpG2CCEPZk0AjRY4+SL4ZkCPPaE6vmab3+2/ncvIvJyEJHDsKhvYDKL?=
 =?us-ascii?Q?dleOoH8xV/YfzCDBdLQZEFzDuDB7Yp/DjO4Xod+D6ASq4wLHU/Ltnlj8uqQc?=
 =?us-ascii?Q?6eYEVmipWMjSz0+CItS4su38DM5aV2bPIbJalTYBYVAhYcMdd9DvzcHT6e4s?=
 =?us-ascii?Q?rm39QUTSkLAs+0McFPccVLInFagldC5pXWQmEvMNHv5xvYOrG2R9swX4Bbu4?=
 =?us-ascii?Q?7K6ljarkpPQHLiiPQhcRHg115v520TThOYJvGfWJ+Vx1J1UyJMpOKkvaUqaK?=
 =?us-ascii?Q?4y9LwySLVx0H4VJYipS9VtVPgLvfXDvfujqLXQHH972UuR5V77adCLYPYXYY?=
 =?us-ascii?Q?A59bLP92BIjA6b6/SpBU5HuiGfnMs+FIuRyPMDfuIoOc4TOMb0YofdAO8ND/?=
 =?us-ascii?Q?JbZiScFd0yVbVNhxaQ5ni6o49EHZCcBX4kO1DDTBgeivGHpDQm86pSYpoY/W?=
 =?us-ascii?Q?OzL1BIZPxay6Vqqy7fX4PrZxjOGRpiBCXybyidNaBNB8b5U1axUxKkHWzi4O?=
 =?us-ascii?Q?6FJ8Q/dDV6rzs7EUf6+3oITFTkrOV/bpzaVeKuEUMWmCpyS2jjETK4zpplxF?=
 =?us-ascii?Q?lZG+AQOK3Wgn2YVEn5G0SrurlePq3cKPUQgMfS/FpeIh/FDG794B+lQD7jmU?=
 =?us-ascii?Q?H9F+KZS/JHAICuWTWxYgxnvGgtwL4VgPnLtEgw8FgXwyFboFfXZL0YyjyH3E?=
 =?us-ascii?Q?Tq64CaegCMuSXtnm5Db0cf16UpKAy6EWks4XEREBl/loT8mM4cyaEf9JyQ/G?=
 =?us-ascii?Q?wjDzCuO8+glQ55R+E0RK2io/O1Q6kPcEpeY45j2lmTPsNTQD3JT9P0WF7mYh?=
 =?us-ascii?Q?Ojn7g7Xp61A8H38NtO/ep//sVn+CxzHA5+M4Wq0x+7Ry9Ct160e7IdoQSVIl?=
 =?us-ascii?Q?BkGlr7V6Ywmm4INnBlf9Vv0ce6aY+1Ql6CDZ7MnUj7LdSOiH1HxpDqYofeSi?=
 =?us-ascii?Q?ZdmBESg6/30FgdBu6+5aHDFzYzV+5fc4sI/mfuqaQkEI5ZOLv24MO7AFmV/g?=
 =?us-ascii?Q?m/EWygCsy3/qzvu59P3cTX8ykBDlScCYfm6uvkeoQZgunWDi7eVED1YwYBsq?=
 =?us-ascii?Q?TGCBkS6ox5rQsallHg74wjS7uRN0cQu0AbKMlIPLpYSwgLYqa1uA9Dl0RhzM?=
 =?us-ascii?Q?Jy+SY742jnsLF5mf1b4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc2006-bd20-43f1-8f71-08d9f09153db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:42:01.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVzyk7UX5DmBIJDo+K5MAsft0wvHy2Q/6fB5IuiWYI1NyxFDeETpva/olhpuQFI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 14, 2022 at 11:43:40PM -0600, Bob Pearson wrote:

> in the write_unlock_bh() call. This appears to complain if hardirqs
> are not enabled on the current cpu. This only happens if
> CONFIG_PROVE_LOCKING=y.

The trace shows this context is called within a irq disabled spinlock
region. Ie this is trying to do

  spinlock_irqsave()
  write_lock_bh()
  write_unlock_bh()
  spinunlock_irqrestore()

Which is illegal locking.

Jason
