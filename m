Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831EC6784F5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 19:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjAWSce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjAWScd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 13:32:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9238033454
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 10:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6XCNzFeEmNcR87d3TtEsy5FmZcuCK/pDTldJvSVFBUcae/GevJygYDT7bx9x+TPGAhmOl9USw7qUiT5D9h5M0Nxn1wL5SDyTxsAQxqi/u0PDOn6wGYRGDjx5hDhzO5HsYdvrCfyAy1O/XiVbYmyj8OFVllt4gxND5dsvFqT1j/2wxS+mhIa+e3v0qplK8Ug9M0WK38eRfKq4uMjH3YRw9qt7BWIjuCS6zWMScYD5e69+c6V6xxUhrv/uml+oEyEuQdazlSMX2hk/FLwQ5E88OfFetgglEn3E0vzpXjMzJmvrsvui4rGBGnFavshyMT+z9BFcMHOruD1L686BOgJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo+LikqfWPmv/Iyzz52jpDFtKVw99yJ/7jM+FxqZT7M=;
 b=Es3XBoJvoygajbb0WbX7Zp6vNB6VQT+GP488s2Yf7KRtfc3z0AfBA/sXwuw2Fl6mLxescMejMQsuum1z3GQ5TaK0lGGSJySfwroJeMeyzYbY1DHr4jgvI3Dy16FzZ0Q2kMMhJryWGXdA3yF2DgRiUmdvByOP2ynee9txe2mIC9U5X3EYw+7QHXxGrZ7go/7/OyiyC215YrRfVZ4nGaikT5/XT8+gdcMhhs7NUGznN/ifSIhdhsbjLNP5yUFq766cq9Vj1ImUZgV+1fUHBkmpWPWDTXAfb9DoWHWfOzjA/jG48/SUELG6Jaasmymw+/CZ2LDyI6pqVDdLNNwux52xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo+LikqfWPmv/Iyzz52jpDFtKVw99yJ/7jM+FxqZT7M=;
 b=djeZAqEFo2XZfhBVYlacOQdk8MWqJ3puMoqGxjhLb7faDtvKDLQJoL5fsAkVnd/EAk/WuL74CO5FyPIMUCq3V/F3GzVOUNcXGsLQEJPq3kDgScOfLnJOLiWKeZiitP7WySaPzMwttNbkx75Vabhngx5+qDaNjyBI6GvX5UEmI3b7PvetD3SvFkt9bmxqbWvr+LsnlqJkwsIZf7+RuqL/Uey+zTjD4YBzbFYar+LJ73QodufSJCuIj9ntsdWqdXCb2yJYi64FcQhAd1rbqeZJfLRSfdvs6rAcfyo6X1wCE9nrjSBvKKNeldq5Y8cMTpWUN8ZgLY64SNwWD/43GxBpEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 18:32:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:32:07 +0000
Date:   Mon, 23 Jan 2023 14:32:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y87SpbbdYE3A+y46@nvidia.com>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
 <Y8r/BUdb7XMxwVN+@nvidia.com>
 <Y80vs3KQ1QfB+KBf@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y80vs3KQ1QfB+KBf@unreal>
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: e66ab866-c2ec-463e-7aca-08dafd70219e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoJU8stbJavlc6b7pqZuRnsjCizQL7orzPsKO4Cv3o72aF9fg7hnc28S9Vc+pFfdYEgdCvHW0cHwLXnbV1cfNkqkR1LHebwH/lQH/VTsXh1R0OYlytyKeEFGn8ZN70524LhMZoUPnAsu5hqOo9hQJTx3ogix9tQSjsNBjiXx6UQcbNCZc68iogzrMMvKgGKln7wwSXl/d6swOfcc3ad+PZymp7l+4uYVhzQoZw8WAfjxpKPz//NOb6cn8/1cEz3UJSxtK7etb0TFGaOeiCCq3+5ZaFasGyBjap5uLUP2CJOejTCuqYwjgM1DR8vH8hgsO9+r0PAgLsz1QmYACWBueXfmTQJ+ZPVISMIamTt+d16ghvi8W7oTn4S/Y23bIirsX89sPuIqToBkkGFSgNmFQXt0A+EJG//xwWJNSR3kddXd9qnGqiooeHYhjWMNJlBB7S1JMNqX/uVVZmexF1nkB6g9jPitLXUUa5kCRrEUF7A6bs3oWJoEE6R1wxw6MtJlDEQbG7TpHC+L3+MFGP0mgj3n4MygENJBrj5kGZpcjlrrdr2ZWRrCFxdJ86J0oc3k4mKkctem7OPr0jd8nDerEzpKajz8wtvl5PP1rV8GPrS1eM8X8oZFUVmYf/6MHjAVTGwbuLv7MVRn58S0QwRCXFKnOK8ncv9QaaUkIgU/JcYKEw/7RvGPjXG2L3qtwCPC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(41300700001)(86362001)(4744005)(2906002)(8936002)(5660300002)(4326008)(6512007)(26005)(8676002)(6916009)(186003)(6506007)(107886003)(66476007)(66556008)(316002)(54906003)(2616005)(66946007)(478600001)(6486002)(66899015)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2tdVgkDQ864UH1UVAUomRDn4WHpjnrQnxiMbPMLsVnHXOUB3cgIBoeFNVr+?=
 =?us-ascii?Q?X0+l7VuZxUyyfJmMDpgF2eUlundCHhLSBJkQGKg2ztTX8kN531p+zSUmy7aY?=
 =?us-ascii?Q?RqekcObZkbe1B0TqFwLngwumsO7IDZOa6QF2sAkuun8zLMjKwFIqvDu8XHJO?=
 =?us-ascii?Q?olj30Chuc1/FIi7HEvFqJmr+UNOs5Ev+vTRKj7z6NHCaBAwysk8pv04AerJ8?=
 =?us-ascii?Q?E/OVTC2GlRuWzTBAlYS94mUtoo2S9NHqP6/UdwVj0YQTw0CqTt35u6XD3+bC?=
 =?us-ascii?Q?2F6PUit+17v46/VazldCI8XSi5SJ/ab5tnf/9pbdruVc0ZSbYtMVCOJ7PHFL?=
 =?us-ascii?Q?YDwbIKtV5yzd3E/rPvhkCOg0bXAYLYNP0zE8VFwnXR+brtrul3eTMWqIn079?=
 =?us-ascii?Q?3RB1LrVPdGe6PAfVyjQYHMbFMitH1kLvaSvrHA1DYevE2XqmVfXHUdPy5s8C?=
 =?us-ascii?Q?z5edIgLZ+jk7YDHNLQVpBNYG99PZquuJYSzf2hGiccP/UlhHH3OD6rCIw1SD?=
 =?us-ascii?Q?EfgdtOOaWq+1LXGX+3Q/O09qsP7MFrFxWmbh83g1Hl0gd9oETOqnpBARdMoR?=
 =?us-ascii?Q?wM7pqaCxMw1QAAPJlYkd3ARH1am/3f7b4O+boifZBm9pDFW5rl4fcCIdmu5r?=
 =?us-ascii?Q?yRqL18wOPMKNPGCbtSrHpcQCNnv35vVKed8ANP6BO38q49x0cUxbIoJ32vJY?=
 =?us-ascii?Q?D8TqGcbqaBaZBdRKA2HeSRXjTkrXn0LOdkMFGaHWCdU5O1AXMiERZk1egv4e?=
 =?us-ascii?Q?uG3W01j7dZWaH0oiB50KxZLzDENwblvK6W/06gLDGVUrqnJgbf6aMAZSdUTu?=
 =?us-ascii?Q?cXJ0fRxbJ1UpieP3EFICO96xLXHFc8m3oXyIuASK5cRnKu85qe+hE50T/cie?=
 =?us-ascii?Q?E7nMyvIX2ZmDOfQVC2Hxq24jN4jATkUZ6BeVBhzderVBdDfOgANnibc9al15?=
 =?us-ascii?Q?WvESyXqMs90kBPggJKR+Q2ExaKeV7kkqSWbNwIJPL+k+N/UgW9Y/GH3WQc7i?=
 =?us-ascii?Q?7ATl/lpcEBb5fsUGv1bTc3zaINc3iTGBt27HrdON2pe4CjYx4yMq5BjB1gMB?=
 =?us-ascii?Q?6v8oA3AR6SuTMyC8XiDboLzZ5exl1RXaV+z5PgT7ntSt2mnnDiyDc1wdCx88?=
 =?us-ascii?Q?tEdRR7OdwK9Mu829Sdii+cSyfB8DyCoYrqPMmAb4IY3c7dMjRhGQ22U8HEjD?=
 =?us-ascii?Q?JaMsJ+RUBvu3g17+8kXvY1Q/5JFmBX8cxAdjzxfhpg/KIise1m7InDLrgKsP?=
 =?us-ascii?Q?jRcz727GA86c3rieOMbFimWElFBTFty/I78pKy92F00BxcOCZWWvjNJB23qK?=
 =?us-ascii?Q?vs7RJ1UGaFe26RBEexWbn7YVzTdf0ZXnVyZNTuabAO49Tzj9OQ247+LZy0aK?=
 =?us-ascii?Q?WiK412XbF7FipqYInusk41kPZ9fYpa02ms3wi7j4zl5S9SMdFw6KmEtLgdUp?=
 =?us-ascii?Q?TIDebbAcaoypOTDifTUaN055bI1K52870nSiQ9Rv5YC3RpepIDplCt6TgigM?=
 =?us-ascii?Q?K9ifZlbN1QRC0OEN7s44Skoe8y3OSm1zBDOMMbXkdPuPbVeDCBcG1qX7veCU?=
 =?us-ascii?Q?HzfWn1d8DXvfAachOQ9t7hrH/BuO3sMHrVmtSKmh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66ab866-c2ec-463e-7aca-08dafd70219e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 18:32:07.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH4m57Ww2AVHOmOC+gvEJ4Og4GgsHe8c98NrsSSfRaMLEZ7KXBhnMnP6Ol56zPty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 22, 2023 at 02:44:35PM +0200, Leon Romanovsky wrote:

> > And the return of a really big number from ops->get_num_rx_queues is
> > pretty ugly too, ideally that would be fixed to pass in some function
> > arguments and obtain the ppriv so it can return the actual maximum
> > number of queues and we don't waste a bunch of memory..
> 
> .get_num_rx_queues() is declared as void, so it can't have any complex
> logic except returns some global define.

Well, yes, you'd have to add some arguments..
 
Jason
