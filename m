Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4B596E70
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiHQM3r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 08:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiHQM3q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 08:29:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD96DAFE
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 05:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVjh5Tg4F9sjrbAe0zFQczIJZ49O83smI2uZY4O2zZWbFhIZlAdRV/LYstyeFYLE+ohDd0r7xYCx9b9gSC3ucKm2Jw11l08pktMzAbGd4CGmhfuCMedU6cBPwfHO7dwaF6FXLcUdBrH5gQUqpl5V+b84tcq8JXJRsYcKwQHxGQ3opYOD9pnva1YG/4OzZKn2VdFh8/lcYCSOddZ04y8fztQe/Uan0g3NcvBAcZmx1VLWeSstR0NT/NBKETp0zFAK58x1eXUCj1YiotBbv+te8g2FsPjb+lz7imAO/xWVHhbkYuzXUx94aN0rxqUfbPcq5wIijXEBmbQ1OzRwmAkuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h01aPlm8iAcpVIGXcsvUC9lNnOJl9URwElIoHN1VIvY=;
 b=YJYGVRHTN0vjldIKFX3Tw5+Ps6P3vJ2Qw+ztaidag15y8Wz3OyywGl4Mb0QheTt6qxCXxgBNaVeL/YrYoK1G+XKEdaUUv5OLuM9Oz8aU0SU0wtVWzXDMQkQJscy5EAzmsc3A/V4QeEMDKEA2Le3DXRwM7ZieZpnXFqHhO86AbpiIU/nYSvzINEG5Y0g1tfX8npnTgY4ZMWvcllQv0cQgtVHk6HvDHUAN9YSiBcG5IYkOMFlDLdoLQx27ii2soi22W8tQ+gT5RMDrcQpoq1OWGh78vTgMZSYPSgE2d5zTGXZFspOxn0Qm6KakE8cMWOY6uAZReDaPp1U2omHLX+1pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h01aPlm8iAcpVIGXcsvUC9lNnOJl9URwElIoHN1VIvY=;
 b=M0XSQU5liMMROUbVMW65utv7Yc9OpHNRvJtqw/i/9w+T0BMHf/zEx7H6hg1Tu/mTzkH1shB+AUPgptkW5JbHJRV1r7mm0mHqr1NKhj9iXD+IN5YSoR53D8cdJrr3rxzSZ+g6yIGLEED4py3wUaOQndC0u2ie4AEf54BiG8JmgpNkVWF7T6veCg6JSXOH45ftIJmam9XtSfRd4Mt0wwY10DwGPka7anjbuJHFsvCFRN6WgprxTE4kRYHeTO+t6VRl97285CfY4lMDeFDG035p6fcfZc9FP+9dBBAqGAViFfZc/hYIrO9syDFQCbrGrQMArs0DW/2dWLqYzqFFWLNgkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 17 Aug 2022 12:29:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 12:29:44 +0000
Date:   Wed, 17 Aug 2022 09:29:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Margolin, Michael" <mrgolin@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Jahjah, Firas" <firasj@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "Kranzdorf, Daniel" <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with
 source GID
Message-ID: <YvzfN6Ns7iaUmyGa@nvidia.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
 <YvuiKpvLtBvKVhkO@unreal>
 <a096d37b-e636-d621-8065-195d7cba627c@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a096d37b-e636-d621-8065-195d7cba627c@amazon.com>
X-ClientProxiedBy: MN2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:d4::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986576af-e94c-437a-81f1-08da804c2a56
X-MS-TrafficTypeDiagnostic: DM4PR12MB5892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij/0lCbpoRceZxtE4tiwUPsGDFCdY//PfUKC0EVhn5pIWSooiFlICpCyUBsL+dFgCVPPaGl6gj4O/PMR1bPZV0E5t0nxUT6FAf0xYqGTiPsoWSFWbYoB68J4ge69z6Z7o7gHVQtTgXp+9qkBVtH5IlOCldNbc2I4TMVW+7rQtE9nokO9+0AiI1cV1equY+t1IouH3kGhShWmkMsISxCcuqtHq8hjH3kAj6ohfNJVOhFprl29PIajJ2wlRfq3x+AWqeC9PfZgCKhbOdsBVgiN7SRcKoIlVDkKfL7n0MECT4yu5b7ZbEPCBmLEH5+UGh7hVUVmdT2O739ZfaNavp4Y/pZremmwNlZrLmC5XcKXrCc4gINJNHP/i3j6uy4FKyR3eTWS+6PZ4G8STp0BGNJRqkkUfkLbXgOYrMh/3IHpGGxNv/bUOroHPFPsABwP7Z3fTCsvVBRxAP5t5xNuTYdS7NebpjFVaAvg1YEDOFuAfoh46+inhZ8cUF8BtGyb4nwtcZ0ECMayu11qplt9tkPAucoKRmaSpafKd3vY8TDruUJ8yWA+nl5nqTYjzTvf1jSiooAjKDSPt6S/UempyfgLJG4r59lt1VV592qF8wXgUXhHrc4hN0LzrVALwDIXucuItcMm3akFYOQ9s/WiNs63Y8jdL4Fm/QKdCSS//LW82zz5Aj+BaVH1YtufAPxZ9N0F+qhpfKMyosD03KhKZwgg/2UHVw+vxHNLRX8QIrsUFLy6Wtzwlk7a4+7Qh4x664bqgaV3GN6a9XSeaIINH5TcAal0e6d42p8lShMo38g8TO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(6486002)(6512007)(83380400001)(53546011)(6506007)(5660300002)(186003)(41300700001)(26005)(316002)(2616005)(478600001)(2906002)(4326008)(86362001)(6916009)(66946007)(66556008)(8676002)(66476007)(38100700002)(36756003)(8936002)(54906003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7XcKCfhcB5tXMEvB5x5/gbOheAJkD7kPzSmBSsVeUKY55S4c6Sb2B+71vf2?=
 =?us-ascii?Q?0EWsmUMeCVTgLzm72qeRdm96AzOSFmtrvHyPdTQolO9O9eRb+Gy3c2eFm6Q8?=
 =?us-ascii?Q?ckGtQ39sHTdp9dQY0XNY6fnnPXM91Nl/xjhzo5TNnvEbPHmgPU5LH1+l02VL?=
 =?us-ascii?Q?AlLLqXS5I4wHBh8OG1e5dLBrKj7BkiQNViIOeIZZK/nOmaJg66Mw/QsMfe2y?=
 =?us-ascii?Q?aJ0qhoWSko+4gYQSK9nMOT/nQ6xcx01lA5tuvwaQx/KYp9naBulzujyhXnHq?=
 =?us-ascii?Q?wEup/mY57SCUa1vEzF6oWaGEoLENr1NPw0TdyjLJgNWXT6TPJz6+Hj04oO1u?=
 =?us-ascii?Q?3meTm4lhGwpuDolOoNqM1jstgs2e14/fj+cFYf+8zt+9aG2e+WIrOYAspjWm?=
 =?us-ascii?Q?nmrE7LU/6K7weY0fJhVX2WwwlJxOOaQhGM4Gl9I7HzVyzpZWKuqmw9mTI1li?=
 =?us-ascii?Q?9RU41dOtMfmiRSnPigqxVbfTTrkrGE9lfC4YRA79jcZk/fzqYMiYVVnCtjOM?=
 =?us-ascii?Q?ucYjxGzmzZnqlh8U988zfmlFwBhtgNAn1G5nmeAZPv4Utl2bRUlJnSYZ2m2O?=
 =?us-ascii?Q?MyyItgyjDSrAEOTyVUjwTlhFDUFQWhurqMYGrYALYFQeMPf32WhJ1ZXYkChV?=
 =?us-ascii?Q?A0ERfG2W0ax02N24btm8r1WHMgk7XC+bq2IKgz7Hg6iM8enA5TMhUQUec149?=
 =?us-ascii?Q?6tl8xXPjArZp+45LKG79QXAYhV1WLge7ckF/1Qh0Rafo7HO6cunqe3SnNRrC?=
 =?us-ascii?Q?o756EZX5Ppk9OZvhI3L10gpUn+qVI+sQhqRTUqt9/CImnZRIhSjCloQKn5Fm?=
 =?us-ascii?Q?0tUPG5DtJnepyrjbzVpaYaG1F/9M5Dfdt1FsVYpWS+bXZKfnjqsqyiQXngbx?=
 =?us-ascii?Q?KbbhzvoTgMGxxTJEIRHLz1ezZwrhq0tJd5bH+J6proCfMNtLpz5MvKTqRWO/?=
 =?us-ascii?Q?/9Tgu217u2mlLoZN9Ffa569eO02/0lv/EDtLhq+HrI9qvWzvLABgToObCDzo?=
 =?us-ascii?Q?rnZVdRQUXcDFY8zcUEbdXJfXYFUn+xepxccdZbeGA0/+uSgOmVQ/Rv4twvUu?=
 =?us-ascii?Q?YXvrPkFeem+4HIXfoGjOhFqbA47jv+qSmVCYln+9oryFRFAMHAmqTri4prlb?=
 =?us-ascii?Q?mveZm4Gg1WKjwZ7eczT0AwJtSck7yVUfRvC/31+10zo6Qe/1zb/BIR/ihDd2?=
 =?us-ascii?Q?qSw2ck28z1V/fL+OuLKHZ+c8JKSXwDcDB+pb89OI9Rv2bMfw0+LMiSAgz/1R?=
 =?us-ascii?Q?CVthDITGUJafE3NIKT8fOH41quMtnthWo3rnwGEo11b7vrDQaWDCEyk86EfS?=
 =?us-ascii?Q?fBw37lf1v7P7hAfHtOVmLmqdwU4282vTT0oW71IguJ+fWeMxCAssoMLyFUF2?=
 =?us-ascii?Q?Jz8UjFd00SD9x2HrEo/iC/GXGEvgoAyiUEaA7Oi6OrmF2yFBPVdAQ9UKeXpa?=
 =?us-ascii?Q?GFxdfba3/CYN7SSNJOa/R3TN4MQvOzyg/sVIkDm+gSZbvdJmoROXjVgp1D20?=
 =?us-ascii?Q?v6vmjnXzf9ygsm3WwhYu8HBFe9ghRRLIIOR+KUXsgRXmWjpXEygP9YkzG0aD?=
 =?us-ascii?Q?qHp4DVasJe5NSX4tCAhTUP5r3ui/VTwDp4fhNnVh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986576af-e94c-437a-81f1-08da804c2a56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 12:29:44.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0OIqFnCPdmxZp/4fny87uH1RsXdL5AVADEinuJbqBe3osDS5MY3b2pjfzG8bYRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 17, 2022 at 03:18:01PM +0300, Margolin, Michael wrote:
> 
> On 8/16/2022 4:56 PM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >
> >
> >
> > On Tue, Aug 09, 2022 at 06:16:36PM +0300, Michael Margolin wrote:
> >> Add a parameter for create CQ admin command to set source address on
> >> receive completion descriptors. Report capability for this feature
> >> through query device verb.
> >>
> >> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> >> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> >> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> >> ---
> >>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
> >>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
> >>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
> >>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
> >>  include/uapi/rdma/efa-abi.h                     | 4 +++-
> >>  5 files changed, 16 insertions(+), 4 deletions(-)
> > <...>
> >
> >> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
> >> index c33010bbf9e8..c6234336543d 100644
> >> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
> >> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
> >> @@ -76,6 +76,7 @@ struct efa_com_create_cq_params {
> >>       u16 eqn;
> >>       u8 entry_size_in_bytes;
> >>       bool interrupt_mode_enabled;
> >> +     bool set_src_addr;
> > Please use "u8 xxx : 1" instead of bool in structs.
> >
> > Thanks
> 
> Thanks Leon for your reply.
> 
> Is this a convention in the subsystem? This is an internal struct used
> only to bind several variables for a function call and I think using
> bool makes it more readable.
> 
> Of course if it's essential I will change this.

You should use bool xx:1 in cases like this and join all the bools in
your struct into a bitfield - unless you can justify them being split
eg due to needing a READ_ONCE/etc or something

This is expected across the kernel.

Jason
