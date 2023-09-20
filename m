Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4377A8930
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjITQC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjITQC4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 12:02:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52582D7
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 09:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwL2TTqGcGAgWyC63fHTVQ7ulLSo6O8G7h2NNMqQjVii5MPxtTa3AZ9YUqYtaTwuGih92Q/z5rOwv42cLlULoOqN2jf7ozUGPOYzsdNtgWIG/xS67xNLqGc669OJazOu+t0jzMVrIaE3lL3t3MZOPC6jbqpGKhEJasScCwYyW1wVN+zsDQHA7cUXR7PuqPR1afsQoisoJ3eEheY9tmcFW7MGylIRFv8qCN2m1ivVrZ4DDds04DtFz//rzerz4jSwHKBWDpSq/6IL4E6UKe6VUZS7oX8gJWUjuI+XijcOxoLJHksLoDeepRBzkeAV8K2IQ4P1mGfyrZDhraaBk7YeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfTRxff0i9Q0Bfef5o0gAzNuHZ0TilfElk0o5YQhISU=;
 b=Njaw7eNcnLbLoD/OMiNrMkPC09bsGvsVzQImzB4wQSnckCsLgUQEjolRmfy9Yb9IbrzLZ9nAOsAzx417FYLCrTOXqRV8krtTdKLpIFT3Sddc7ZOYAImPxsUsgnR+jkMJKErlk40WYUMaPtpxPEOGZSBLIqKFFNaDBGLo9jMGJBEt70O1wQXAC4HWoZ0wxi6W41CZMksHtWGLZNqO23fpb6nhq+WMKETrqACQ3Z0nvvdU7T2PfSBmiC2ULdwgufimdfQf09j2saLOOv/cbd38zMfY2HnqcEsf32yznK2Sjr0v20B8psMNon7CdygsbUNTOyn5HLiG1kJmLkWdH+nUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfTRxff0i9Q0Bfef5o0gAzNuHZ0TilfElk0o5YQhISU=;
 b=WWt1v7QiUpsMT6MS0EiBbjRxKzq+JH4+N5mpRZmMgkNLWM4QYjka+YuXjrJeC4Gnb5iSx6IC/X9ejvtJDq2LAZWuEfr4wgi9Lf5KrpknqvGJSAjgIhPHpV5Mx7JaY0Solhi14TRFA7eBipwkNTxCiMSQb8avd+60eeFmWhhWvWDMrMteAVov9qndEv16+nStVRsxeVgW3GA2T4rI3DxpHRzSg48M6JMfxYdCoJLjjMMdR+UI0C9xN2/GkfkbPyygtOXUq86RUgZgMcgz70bxKT2mt5qnYHPOaAY+TKjbleBFXT31kzLsS97PFSAN/3sd7w/+fQKNFpP6ml9XWkPhng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 16:02:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:02:47 +0000
Date:   Wed, 20 Sep 2023 13:02:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230920160245.GC13733@nvidia.com>
References: <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal>
 <20230920125507.GU13733@nvidia.com>
 <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
 <20230920131032.GY13733@nvidia.com>
 <CAF0WxhnXDfXE94O7etK8edWGiA+b4D792sNzz8b7w7H7D_=kvQ@mail.gmail.com>
 <20230920135541.GA13733@nvidia.com>
 <CAF0WxhnkRsTz_K==6jzkWmggpH+aAXRvWz=2i5==h_thqkYzkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF0WxhnkRsTz_K==6jzkWmggpH+aAXRvWz=2i5==h_thqkYzkQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 774e8c22-4ff9-4764-f71b-08dbb9f30840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJNGv1N4Ntk2EYolKUmmvXNrxC/mW5vc6HpuglfYEGWqizRXaqz/kNtA6UE/Ps7PowKVGMBgf+XuqcLkKPzAo77eX6M4JgKRjqV/IUd9W/WFNJjDY35KbOfx4l/MrmIY5AMby4v4nksuZj6kxMxapgmm1B1D54S8EJY7DKWDlEsuL9OutCrJ3nsTQS29/Dc3BwfzzrULV08hRZATniBljI6F8/9rUR9OdrU+45psKxtuAdrmr7OTGL+by41mhWGqsh/G/mFXuqPGaSdp/8lQDAFlJNqHvMzEATmd3UZhA8CYmXMDM0y8CmlFbmXfLz/37Qnipn4LH7e8pv9QD37jVt2GGoJVrqSSZjxHDDkvAIcw5iM+fEMUqrszO8ptNYLuLUZQd7ARkREIUWBEV/Vo4ZuTZoHxDC1GSCu6LCsMFLQO2GOzU0Z94Ouuxtkp/+8JqUrtyxNzzN3J9VaEPEFxs7yg9D8P45vA8kElYb5Qf3wkCyBWKktCqSZJv/zVMvVf8uCJY39uvHya6QW30insdZ8QVDdH1aaGI4mmyQmYTaFplel+p9tfENSm+4n0+q9S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(53546011)(86362001)(6512007)(54906003)(66946007)(66556008)(41300700001)(66476007)(38100700002)(478600001)(316002)(6916009)(8936002)(2616005)(8676002)(26005)(2906002)(33656002)(4744005)(36756003)(1076003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBqQjV2eGRqT3pvU0JPVEVTUDZuQXNvT1JMWWZlRmoxVytFbTBWVWxOWWpQ?=
 =?utf-8?B?OHQzTHdXL1pzcmhpOUtGdm1SdWdVdXZPU1ZnVnY4eU1MMUhkREk4bEhTelUr?=
 =?utf-8?B?UjViM2k3QmhlQ1ZEV2tEU3ZGUllLMTNrTzJGVUF6Nzk5ZlhKVnVRc3JEbE1Q?=
 =?utf-8?B?SXF4Yk9Kb0tZVk9WY3pHN0NTd0M2VjY1ZmFzby9rSndTdE5FR3E2VjB6eUFv?=
 =?utf-8?B?c1FEYVFoUjhOam1WTDZRRlorNUxyNjZrZlhieWtOc1dEQmlUdGV2VFQzMjhj?=
 =?utf-8?B?dHZBZDZJMDFZcGx4Y05XdFVlUkM0d1F2Zi82Nk12YTVIalVqN3pqYzdIQ1Bl?=
 =?utf-8?B?dFRydVhINTNCTjBNQmxUdGhXOTlRQjNzNS93bEV1Z3l5Z204dWV2TitCbldi?=
 =?utf-8?B?TFhFZ1lFSVhkNUZZRXNxT0luTUowSUZaVlhuL1pLMmN1d3hHbWRnT2xlUEZx?=
 =?utf-8?B?QzhEMXYyaUh1VmVZVGpUcTJIb0I2QWh0WmZSS3ZMcG80WDJXYS81N3RWUDRN?=
 =?utf-8?B?eWxEQ3BzUklyb1NXTVFGSXh3UmhheVUzZWxGd3AzaHU0RWNrRkdkYnhQaXU1?=
 =?utf-8?B?Tm1kVmRzN0lKY1Q5dkdISlBBb21YNnVEalNLa0ZBSFFqUDV5RFJUV08zei9T?=
 =?utf-8?B?Y3ErOC9EdDVnZWlUZk5ZcXRaQ1d3N0FqdzlmVzFPdnVjTThsaGxua0FpdE5i?=
 =?utf-8?B?a3haU2hlVEM0T2tRejNhbVNETkl4a0NLTVNiSlUxVjBWY3k2NElyenFweFZR?=
 =?utf-8?B?bGpxeVBtc2xrS1ZUcC9XTWR0cmsvc1hPZDU5ZDJncHE1MVZTeHg2TEFTRVhn?=
 =?utf-8?B?Z01jTHk5cm1NM2ExeEpUNzd5RU01VHBtTnM3RVN4VnBCaE11am1HK29ZYjZU?=
 =?utf-8?B?b09JSjB6clhjc0hORzFCTXlMV1lrQ08xTjN1NGxKNms4MWljRnIzUFhNR0Z1?=
 =?utf-8?B?V284WWRpd0Q0WGRMSmkxWmlhcXg5WGsrd0ZWL1VtT0F5SVRDdlE0Z3l4QWd4?=
 =?utf-8?B?R3pTTkdHeWNTVmNQQU11YnZPL2c2b29zVlJrejR6RVZTeHJnV3BPUUdIOHM5?=
 =?utf-8?B?dG5Dc1hnMkJ2SkMzclAyQW1tT3MyUjFzd1hMOGo3MWw1dWx0UjFORTJFcEJD?=
 =?utf-8?B?NUFZZDVHd2RxdFlkS2lqSW1IYlNYQ0tKQncwRVZtQitWeFFpVjl6UWw3VWxo?=
 =?utf-8?B?akMrdnpBMXpadk1hc1g2dklkamJSWFNxSWhPRzFoZkJEVDZkNkxtVndjN2pI?=
 =?utf-8?B?RjNseUJYYWVOVW8wNWl4UklDQTcvWUVHcDEzU1NYN0hXSkVnUzZDakdBUXI4?=
 =?utf-8?B?U29ZRm1NV2xpeGU0eW9DN2RuSmRrOUJCbEE4MDhjVHloeEVGby9WWjJNc3hm?=
 =?utf-8?B?QTlraTluUWZjeDVIOUlpc1RueHh4UFZLWUcvTi9keXgxM3pFdWs2RklGT3l2?=
 =?utf-8?B?eWJOTUp6cE9WOEhpd1FpbkR4eDhQZ0twQWpwTmJsTXdJeVF0RTlNYmFlN1VJ?=
 =?utf-8?B?eWgxRWxwT09uQkkyUmY0akYrdTVXNjJqS1NORlowZXo4NWxJSjd5RkFGMFdo?=
 =?utf-8?B?UkNIY3J4T0ZMRVdWSzFTQy9UWGdRcEhtL1JlNU52U3cxblZwOG11OURzTjRo?=
 =?utf-8?B?TGtlcHNrL283Wll6NjJhWUNLOTFYTndrdHdZRGJ5d2czQzA2NmVEaGluenUx?=
 =?utf-8?B?VFdidjEyOGxTeUZ3d3g1U2FZcjNGSGs5cHhpTFlkT1lGejFOZ1QyRDBOK3hM?=
 =?utf-8?B?b2o1T05nU1FYYU5tZlYwT1VVWEdBN0NkR1RDRnZTa0lJT00ySU1ZTFRpUGFP?=
 =?utf-8?B?S0ppL3pjLzNDZC9lWUNlNU9nTUQzYjVCNXZHazg4R3JYdlNjRWlwL2N1NUht?=
 =?utf-8?B?ZEI3YjFncllaSlBCY1JNei9zcnRYTXhnaXVYSnlUNHBVc05ETTRYQlk3Y0VN?=
 =?utf-8?B?TVQwVDA2QjJUVXNiRkJSdytZV2lESmRCYjlHVnBLd0pXQU83Ynl3UUdleFI1?=
 =?utf-8?B?aEtycUhvcGVmMEpWZG5IOWcyTzRFNHRJRVNLVThONVJ0NGxaWmYwckYzeDll?=
 =?utf-8?B?WTJEWHpHa2dYMVVvM1FZcW1pTXZjRmY3UjQ2REVJeTZTUXFyNzZ4UTc4dmF6?=
 =?utf-8?Q?m5sQ8I37UpH04uhUKYDY746oR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774e8c22-4ff9-4764-f71b-08dbb9f30840
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:02:47.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fc+JHJJL1QXQMZsZr+4VDve2tf4bVSTqkp0X2gZJsQQkmkgkivShm8qn6JjTtzp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 10:24:00AM -0400, Vitaly Mayatskikh wrote:
> On Wed, Sep 20, 2023 at 9:55 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > And what happens if one of your non-standard nodes points its IWCM at
> > an IP that is actually running iWarp?
> 
> IWCM takes an IP and a port, creates a socket and listens or connects
> to that endpoint.

It is a bit more going on, but yes it does that

But also you don't need iwcm to do that, just open a socket in your
userspace.

Jason
