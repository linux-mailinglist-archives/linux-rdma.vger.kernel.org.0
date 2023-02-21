Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82769E83B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBUT1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUT1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 14:27:33 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434F3028B
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 11:27:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDNvD2Nv5hobA0EZ3FCUOuUiW5j6qKDiImp0K2knNGwbSjj9GtBOKtBcwTCCVw0d4wj0Xr2hPK1YOo4LzRvLOVpWjw7/qk9OhHE0G6aqlu8JS4xyyvvFQ/QxDh+V9ZlAsK/vFa11atiXMJItVFFR1MPf+7GNghQD6/QN3F15jarw2lADnS+HpHSiq/F3mYfT182vQDvm//UjpzBo1i1fGfZSjKZTGv2ya7Q06P1lSuD60FVTjcdO2qOrPbqXLwU/0TeozlYeWQQWAnR+2hbEzGBaXwtXhfWKCYy61erJblbZbH+wssKp4VU5RSBtMPLgRO43YaDR8M080HPFyVjItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXJdwuL2DTblyJHewmv37MSIrFvmLJWWYtdQXn64Uc8=;
 b=P2bh2dAlLUte+jj2VeUqdtsPixVADfuWYFmQKjco6mtOtO0c3TCZX4Q2iX+Wmq3moyhnTR9mHuMdkV9M603QeTYaPuknww16qdSZxUBDrQM6Oy7zyXt6HChij6R6P9byLLc7HScUjXGbCrY0/Tg7SJXi6wIguaVpdJlZAqhNuLxLsmcBwURtmfK9JVULPlu6qYBxGXYB2Xywb7pMYWwgHjS3ZKIGY5sQ1Q/LYwStW2fSP7vr+k/bbuYH0Z/k5GN83WcU34aH+RiLypFi/LZuQQYiBc/qnq9uiIxTUHEZ75IMAA7zVtd+ecAq8ZewDewiVI3KCKDCZLrY5zumW6RxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJdwuL2DTblyJHewmv37MSIrFvmLJWWYtdQXn64Uc8=;
 b=J0DHqTinTLovi2Kbfs2JnbaE+l5SMp+CJSerfCjhyWLy6bkrc/QJJLUcMxf1xcmeX9/kiRmsLSMhyxUMh3U6LwjEbPOep8LXpQ6CrpC7A+Gmw4gnXamazQ7e4hzeViJCVw45MQMAEELKpafOJpcGA/UjJ3DJt9xRm98l8b++Un8t7NPjUsOve7UHggM6oJnvcBiiqgr1kwIhfT8XfBYI3UBDmjA6nPJHsQ/g/k+QYSdJMqGwXUZoC2oPcSkBzAj5akIVXng6ZV4AxkD/QbNOk4jMFgD/8U0WlSbrRzNLJ8jpGv71Tv3G5eAbHAizQxWX1hZCmPguo2ERvsmBbO3c5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 19:27:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 19:27:28 +0000
Date:   Tue, 21 Feb 2023 15:27:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Devale, Sindhu" <sindhu.devale@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
 deleted
Message-ID: <Y/UbH/y9hL3g1iXp@nvidia.com>
References: <20230208162507.1381-1-sindhu.devale@intel.com>
 <Y+kq5JZ6/BjZgy4e@unreal>
 <Y+pIgRtPanNmqqLN@nvidia.com>
 <SA2PR11MB495317E34938F8A4929F0C40F3A59@SA2PR11MB4953.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB495317E34938F8A4929F0C40F3A59@SA2PR11MB4953.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:208:32d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 1189215d-afd6-403c-19b9-08db1441ab5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpmrcXEVQaB2otKciLq3wc1RD9/DzksVvKtcrTWnHBDmZv63Rv5KO2tLko4kGx0iHdZCt84DS2NatVqrSZsqjj4s1tTQdrw+0wh47hL/dINg6KaK8OGffJ9n2Qw216NPmTnq6T9hlrP45I8GV1KtoHkzsZP1sqIwz67kzT9maPJvA0Deao1X9gmItgTsGPNfv8G/CMaHT7sf26fFiuDMSrrcH2IEZDLD6xKmnn2kPpCvhiTQYkVtJpQd9VeOH0IXYHJmkxRdnC9R/Yq4JSSjYaKNTwIt8Ir+AzlOIi+R39k5Pwb+OZh/u6TsSR075Afyenq5yqwBIc6qwyAVtcRGd8eEP2kK0gQlfJBHCnaZpAjIf87rJdUWZQt7OLr9l67y9UPKXlojGt8u85RSIIRGNerh97PdruXvPIQeoDRjsq2LaLP+laqiBQtZl+ZLRWH/a7Lm7s/Kjjb+1i+ZMayf9Oya2gOXQQZOegDDBEvI/rpnUrwCepg53hWNeDI7wtRBtpCrVWJpYukhzpspBYbLic7YI2NS704Db61A29hfYCpVCrUwPZFzQ9yRJ1yIhCfOwlG9gRFIGWJStKNV/Hm9LdlHSJAIOlM2HIiSP2PPTx8dhOCHC6Vp2txkU8yfrTqJq2CH2Etc/hE17Qu2JZ5j9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(38100700002)(54906003)(186003)(316002)(6512007)(6506007)(36756003)(86362001)(6486002)(478600001)(26005)(2616005)(4326008)(66556008)(8676002)(6916009)(66476007)(66946007)(8936002)(83380400001)(5660300002)(4744005)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTWYyyTQ+tt60Ag1M7TZ7YjjCAcFfTRsYK0IIeIPPNgpskwDbrc0WrmOiPo/?=
 =?us-ascii?Q?zXNmLSv8DYDEp4KVqK7PWklVv7ZJDAVw9LwNZhBl+5DIGmFFTseVmgpYFQ2T?=
 =?us-ascii?Q?wr2vYlJkwcQLNao2lQ7if3VYjpheIR72bGpUcAMKWoZ23ovt3B8HGKP2Pv7r?=
 =?us-ascii?Q?X3cWSe3LwwfODb7wCJZYZJliTDfpHW/hBr+DwOtLoctMHFc7Cbyp0Utc9mLZ?=
 =?us-ascii?Q?GYlWaDwIfGHT49/XiAx+6JihKWYNFdoknIrsjEd8vqJckNaPP0JgnX8dDeC+?=
 =?us-ascii?Q?55ay56kefpNFBTFeLwRun6CCfZPJ5EU93t5swiKT0zq2CP1LECihLi89+gc6?=
 =?us-ascii?Q?XhffJjmTgfY3mmYAxigeWAJ6Q+BYwVsc1w9Z0H1TZPUs3uxgChsvASnr/DG0?=
 =?us-ascii?Q?4NVWoLdX8L2kntMBAJgsCVAHsnGTSQz8pwW1xElVsYRo7aIpDbIDsgC9yW4X?=
 =?us-ascii?Q?9+D+NUUAvmxzm82+O4Oun2s4QbQLlwn9PKIQMjI0/5fSgwBebP2hfhXRKNUo?=
 =?us-ascii?Q?MumlIdooChUf05jwQqgJGIEy5lEG3ggLXvwBXfNfx0tq7JYhzVhZJyWnq8P1?=
 =?us-ascii?Q?TFpkz9L7uOPaW1B+AHjxANIHdTtOqoeAfvGikrvz1sRAFO4Coh8z8/uA3pJr?=
 =?us-ascii?Q?Y1LTmDC6j4f99Ff7KqvO5QDD2Iqo1Uk19oTjSxyVL6MxzPLnZuIpQI1ojFVy?=
 =?us-ascii?Q?yeKxZ2cqDHAAuKGStL9R03KGDahSQL+BguwZ/UirgqgZe2+70wJG7FH1thpF?=
 =?us-ascii?Q?WUBVHh3pz+3S2+4uQv04QvJ6Ls54zP4/eEUffJD70HC3BGui2Niq7wjrRi9v?=
 =?us-ascii?Q?n9tPNnWsqqsQlLfGIKx650FJFekFFPz62BDT04+8xVpdlhq9Ib8g4AiVFc5M?=
 =?us-ascii?Q?pdNrsKw2h+xkK9mYlRH7R2ZyS8t6rckJkpmWujIftB/oHGpeh15NYozqsJGB?=
 =?us-ascii?Q?fpKHmEe5rLrXWHeoa0T8vA9xGMBk6xLF5U0gydpsoyH9Rp2cWH1JztokuaK+?=
 =?us-ascii?Q?kwRFxCf+3siTMjoo27dCZcFpPri8hxyKDf+tDtuBjkwdUFuUi0z3j0AqWEGM?=
 =?us-ascii?Q?H4FBx3oMpzyFJKsthsTNp3QPZdI30YqGm0UeAaK1uQblnL2k6uzfcI+KbZpU?=
 =?us-ascii?Q?Cm+ThG8X/zCL9YQyrL9D27D1b9ExDPpQS6UXdLtvQ/dBvEYVl1ighz/w6cT6?=
 =?us-ascii?Q?yQ76tL69mE2H3MndYn0bScv96VLe5m/E1/dR0/81EQ/x9HyDXRfn9Zragy38?=
 =?us-ascii?Q?21gUg/eW8EQsNHAt3XfvFU5JKoS6U0OaxgnRhQlOZiWywikNZUEMlAv4N4VF?=
 =?us-ascii?Q?ZLi+LkU2/LNoS6in06YuwVtlkNfec+ql8fFAnDE2E+iZYDKUF7kNJPbZ2pVs?=
 =?us-ascii?Q?Ys9+ueCstaRaGiXKLb6YdoRvwCoAhB1ppZj2mHkAh/bEiaIcd9d4NK3pg4pe?=
 =?us-ascii?Q?FP7hGFAOgH5pJnKOuJsslwLC4hWmgKK+bqq28e9WrpI5aRxGN3yhOECk77qV?=
 =?us-ascii?Q?xBhJX/JH2EzZz0ocS41Ureq1PY8BMqhWBtA2G3Xos58RwXlp6PcYt0BgTXz5?=
 =?us-ascii?Q?buFECLhhj2u+gzvLj6qCi5foR9EUvitPPt7Ab9xo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1189215d-afd6-403c-19b9-08db1441ab5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 19:27:28.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHv904090HzwZhky/Hjl6zwGxpoZtbuQia2LdQBycnSq5VmH6JVt9Cpe3+zkOWXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 21, 2023 at 07:19:59PM +0000, Devale, Sindhu wrote:

> > If you HW can't handle invalid GID table entries properly then add
> > code to the GID table handling path to fix it, not this.
> 
> Hi Jason, is the suggestion here to move the code of erroring the
> QPs whose IPs are deleted to the del_gid function callback under
> ib_device_ops?

Yes, that could be one approach

Jason
