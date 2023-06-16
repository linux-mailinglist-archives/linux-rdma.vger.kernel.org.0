Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879AE7339D7
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbjFPT2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbjFPT1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 15:27:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE949E7
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 12:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPgO3K25GKYZy8+k0QU6VlJdt1E9W2vGwvCEV0AFVIFt5TjfRzZA2WPe73xwnN/frKrXV9z4UG0xiTx0jGJuPenaOtvJT7N4Kv4SZBNUtSwyJ360Z+b10uPNQdRfOWuJhkodNo0NvOyxMNinrkNnrlBXv5yXHNlWqrj4XMk8Yoa1mWGW7vF+Gf5oL+yYC/fsl4h/YY3dWUoHU5FydYnfmycanKt2v/mpjkN11CTAjKZwNv7KINM9VjtwovNyyJ4TQVd94BJuztzf5r4qKO4pkFvS7Low1TPDuuHxmZRZPy9MDGvNyEmVoBCRTIBa4yZRtexuGfr3a2/XVN1oGSPAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mSbGL3gNOdlFAzr1R/cgYoDrRUVyBNJOrAWQiO6kCg=;
 b=lQzImgUARoqAaoR5f6C24M7dQ/G7bSeTSPQQGh6P5SDMztXhCnMDk/nphuKGrrP98RRwvvcOUtGEPWBjiF0PQflEL4ZXfxSGnzUupboSyYZ5nUwcLt47dJwHIJUmNIUuYQPADK3BuG/otqoMDyypM2HcB+9Erupv21NgNKtMVQHvfJT2TW8O8wnDWhG4xv2JyeWZHb4cOwxlVSloQsbPZ4yKKzx5io1gCWdS7CwSUS7mt0ZxMUR7WEmVUJwSKT4VRjdJa097e56Ylhkv2dRMx8eIEsW9S9nNiGen7oPhv2B4dXIRJIbLuZCjq7U7/L3W/l6REQQTFrCTx76gWN0XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mSbGL3gNOdlFAzr1R/cgYoDrRUVyBNJOrAWQiO6kCg=;
 b=P0DeQ6wx5jIG1I2Bq4EXPJiJwj1nzPWNr7SD7YCmC2bbtkJJ8ovv++anVxgTGFRiqUW9RVbsueL3fv4RosoxvBuV3Iu0uENYyRDzg2tCFrifTlQvcFyFqFKeLj0oD1n6NOISHmMAW5JdeP5GvB1WRnCeSrkdsoGWE+iuX8KLB2btkUgI36Lvq3MIgPyKGD3yfd+LndnQv9lAxqoRPCGGtu+WINPTmOlRqdlPJASLiMR/NXwhLeKIH8NoLhOWdeDAwqaxlB0uKE17nSiNffleGA088gBn+NxnRv3yHB8MVy+DnbPv/FuifCaTHChfQnox0hvkXqzh/dk/GL3xuz2afQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 19:25:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 19:25:58 +0000
Date:   Fri, 16 Jun 2023 16:25:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Message-ID: <ZIy3RSokVxwnfdFQ@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
 <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
 <ZHnx2xu/AmkKFni4@nvidia.com>
 <97b685a9-cd0b-023b-75f1-48c8df06a2ad@cornelisnetworks.com>
 <ZHoln/2UL7avEou8@nvidia.com>
 <ee887b74-929e-739c-f472-cce7ea7a4d09@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee887b74-929e-739c-f472-cce7ea7a4d09@cornelisnetworks.com>
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f58705c-1f84-4421-d4ab-08db6e9f8336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smvcaBQdD0meXjeRptjf4UNBlbfu8azP78fgzczpCrpMr/yRalE7w5Brk2eStjpVKt9a5JH2R5ncGU/bOKgRJvjXEVdnS3uS+s9xH3xj9K2mzRrUiS/4mrOL+Re9UoH3unnOAG0II9Y3bdgiZhO0j90pZGDV7uvnj055OvI3Lgb9tNKV3Rub07g1n/3Q3L8Ef4H4TEfyLS82UVSZmTJH/z3s/4ngNIIBWK0i+oLM7Qhgayi3Px+IuE4wd2EItrqFlx3SBqgItI8A0nIWTXVvIWo6azCoMjvs+otobJhrRILWoe6sZksHD1TXBbRIrgA8ZuaSTAGELFga63W2k6aiDf1jGeQ+6Oe6MUGTuesbpcWoOxqbL2dk65OZgPtqMDutbNNYrpmUQvMmxIbnkXhc5Gnb9k3+cor5TTFPYWCUrfb9HJsMGzcLJrkVlCRYmpkVsYIBe4fPigTTlm4cisDV+5w8mSxbEe1MyaJogZrPcsNGetueJ1+6sPWEBZWJUyKL3hwXGVmqUy/c5wsNGUYzPFalMlnHSIJ/uF4tf11ARkL25eeU0RbKib+nnVKyvGoO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(4326008)(6506007)(6512007)(6916009)(66476007)(66556008)(66946007)(316002)(186003)(36756003)(54906003)(86362001)(53546011)(26005)(478600001)(6486002)(38100700002)(2616005)(8936002)(2906002)(5660300002)(8676002)(66899021)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBs3ijzlvQp2cFJBC7da1Yr4HPijxsCt60W0Uose8xXBS6AJH7gHBmaYx0eT?=
 =?us-ascii?Q?X6drIetJYI/YHEbv5LSkvt4VAhVTEbHHDwXW77r3p3m8DDZAwC7bhviu/uum?=
 =?us-ascii?Q?FPiVr1C/RwN8Pdrinx6AUiYWZ683qxZdeuATsriZy9XIP21Sk/tydZRNLV5t?=
 =?us-ascii?Q?fUKmM+R8OQQ1QKeoTwK1kzHyyPT1sFQtTziRwzHYMJsAPaCEMQt6WENtg9EB?=
 =?us-ascii?Q?RGSU+fiD92Nbc4z4h0fkm05Vs9s4WY/A2YQFTSIVnsEPMie5hKkRQ0JbFXFt?=
 =?us-ascii?Q?QMXml9ZkdyCScn84GLQM1NqUuhKV08g9NwaukuBcXqk9+Iam6n7BgI4G17Q2?=
 =?us-ascii?Q?HFIh+n/wo02893aYDkjPmtFjqamyEWgTjFFtMKo6uKMk9IqCGXGVva90y7HK?=
 =?us-ascii?Q?FMd3J5kXdMlmejP4JWKWAM/i8UHEiXInB/mKSZbNUDGyH2Nw2EVtcIf9GAXV?=
 =?us-ascii?Q?pEcwAeEsIUG/BVzwVvQE+xbaddL5n3SLYW7a96itMibjv9O3MrMTw3vYRuEV?=
 =?us-ascii?Q?+w60lFOUA8l5Dk7TkjzZ1hgwAdoYwLMX1akKmmTUDHRTum+eY0fzPHhlG0DK?=
 =?us-ascii?Q?edZeSomdP3geiFBa1d9ZUpmEjn7EZgcZG9OShGPf4jzUaFoAD08dXTwG/NVa?=
 =?us-ascii?Q?8KrwShcvgbLflH2TLqgY58Ryo8+30mEUa302s7/v7KeNsUc5B9xSDlYfm+hp?=
 =?us-ascii?Q?lqeiEPi0RVwNUEHYK3uYTtj9RoTIarZznomT43qZGtXD26WUO9nZM9KzGVWW?=
 =?us-ascii?Q?xLqVr+NZTtLjC+7Jk9vPk7WhU26F18KT7UlFU90Nqy5OY1el1KlcrS9vlfbU?=
 =?us-ascii?Q?Im+7Bzok2fykQ39wJFr1aIxh9z+G39hYM8S+3cAs2qD5Nr0v6tefOOGD2Hrx?=
 =?us-ascii?Q?FCXfe19Coy8KL20+MGfN98s6BYjc/ZcyAWSaLfiNoTrTNtULjOaiR3MwJiKE?=
 =?us-ascii?Q?7D331QwHgumOmodhKaf3QCyIFrkyr+CoueWYD4F4+e3RD3/uNJ1xubm3EOc8?=
 =?us-ascii?Q?arx2njTC5frUesA4FLWDuKx1NbZrRTOXx2uXRdPaqz3gJLCDGX3111+YDoTQ?=
 =?us-ascii?Q?Lzjlmp/FTrasz2AMlvms1NhhiDhDevk6Ppo91i4ktRfNrXO0UwekHgFXWX9T?=
 =?us-ascii?Q?fa/MNmA6D47qGG1qHesAHvy2M9tQ1rGo7XbLxhYWqCXeTjlygoXT9v3uiUWV?=
 =?us-ascii?Q?QUon30Wjb/6BS9gIgNV7jg+uKzY4lZyjzbdgQFlivTHvxYtBRXbV/zb38Fe4?=
 =?us-ascii?Q?Iw0ntl+sC0I1yLbY17L6lQ2D+Zjb2Rn7+rTX5FO+LkCcn04bjs8suuFpYCS0?=
 =?us-ascii?Q?uOUlw95pbIagCod4QwwU/IYVOxGcQSEAExZz+hdN1UKjzFnfFNAjtD8pqI42?=
 =?us-ascii?Q?zwQfO7LlnAFXc1PlS667U5u+hu7IkqF+jrDvjlKvmVsNpMQmj5lOhg647WaE?=
 =?us-ascii?Q?23HLhp+b33RRuL7nCASg57VRzX5LhiSULnrGeRjEBp/sBsDV/dDM+yJUQ4jR?=
 =?us-ascii?Q?yjeQu2RyoTcFK4FNyc2WsdbIvF2E6y9QDUwJIoR4L5ECwj3CKSPNJrDoF5Yc?=
 =?us-ascii?Q?MqzUE2fOl43AlyEItlk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f58705c-1f84-4421-d4ab-08db6e9f8336
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 19:25:58.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuVPKnodjIC3fRp9lzvs7OjRh4x0nvd67P70dRLP+lXPrKV4Qgxv9p+xzTPSD8nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 16, 2023 at 12:33:40PM -0400, Dennis Dalessandro wrote:
> On 6/2/23 1:23 PM, Jason Gunthorpe wrote:
> > On Fri, Jun 02, 2023 at 01:15:47PM -0400, Dennis Dalessandro wrote:
> >>> So you will have to think carefully about is needed. It is part of why
> >>> I don't want to take uAPI changed for incomplete features. I'm
> >>> wondering how you will fit dmabuf into hfi1 when I won't be happy if
> >>> this is done by adding dmabuf support to the cdev.
> 
> The cdev just needs to know what type of memory it's dealing with. We expect the
> dmabuf to be allocated and ready to use. Just like we would a GPU buffer. So
> would you still reject the patch if we sent support for AMD's GPU instead of
> dmabuf if it's all in-tree and upstream and we have the user code to go with it?

I don't understand what that even means, how can you support AMD GPU
without also using DMABUF?

My big problem with this patch is I can't understand what it really
even does because it is somehow tied to the HW functionality. Which is
also very confusing because DMABUF is supposed to have general MR
based code for processing MRs.

We are not able to support DMABUF on "ODP" like situations, and AFAIK
this hfi stuff is basically a weird version of ODP / some kernel
support for registration caching.

So maybe if you explain it better and more carefully, IDK.

Jason
