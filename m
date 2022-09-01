Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4785A9769
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIAMvi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiIAMvg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:51:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987B7DF48
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 05:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIJDvYyoco2NSWeCXrpYd4d4A8L6MwiUE1+zCdVrObbSxeA9VJYY4E6xbJF3rHdVu6q/TUC1mxkz5NW3Unx95qqiLx1QlRyFcfea98nFSuJS9ReauGkdokLIpGVQMbGGy94Msn4hLsKLLEjLkOxSmvUbEk7MJTW+U4DdYOruRV1jqC9w2EFj0qA15hAU6PY2Haa4ltdQ5Kh1HKDI4JrxldJ8WrTVZBX8EBK/RbGp9EFMrdeNFcNATdEZhao0yzqlbghg7+CvX6XJvJY8YbOTTYyIs13EJWqINfCk24lTmdUzLxifhjKP4q3F7PF1rhqVyFPlW5XkUqIgy9aA20vS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cilyksvPb4/Qp5fyJSnCrI8l0Y8+u2KKlXnj68PhjM=;
 b=JxOpk11UMfbdzPTNnufFbf0NFX+149hV1HJZ1s7BiFSsrkQ61Pe9idcv2LHLaJtWZvzLDDjuPqzpEcDPS3/XqNbf43OHRtIsNmM5/25hQMmF8NY6abETr5JU8twSa8sFs+/cj2tmFVndHJ1173Fmc1LUCXLNVC5f+/1a5Pu0iBNz+a1ZL20Pf+kbXRzwV1Scpag1sPw3PMEYpdbKPyG9QwuWAIjnflMs7Qp+ZmKjHMtjMYC5L3XRpGYfJg7wqVzw5Lw9uvPhSmjpUkrq6oNr3OzdvqzygETRFxXpZzFQivMAMo9Ygxu9HcgHUtQLDn2OUZrr7kpfxfa6M4FpaXJrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cilyksvPb4/Qp5fyJSnCrI8l0Y8+u2KKlXnj68PhjM=;
 b=hucqnnBm9fV3i070Gyphnce71gPkqRMGHqk3gkTqUyy95f5kQ+fd3sBzypqVXdUCo6oZmtGyY+H42Jo6sehIZy/LDl3grvpjlVB8KBfb2MkBOwrDhlEVWucE/nyQRkvjOqE+7izZqRTOAkYVxORBm6PRrFSlr8yPRG/XnvTPqJCYTAzAHSAklUAD5Vy6NrPt+O2YiZYR/ePSCTHWZich7ZXwuLD2PqSOeXMQ3VmocrADGRiJLPGKfZmdGF5guDfGgUOdIDzXL/3/EJXmZhhrcG836DZBKniXrPufvMSpCSGSLmufCCTP7hvx8GjmouJWI09yJno42vrCA/+2fPLkCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 1 Sep
 2022 12:51:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 12:51:25 +0000
Date:   Thu, 1 Sep 2022 09:51:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
Message-ID: <YxCqzJtLdX85Agg+@nvidia.com>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
 <YxCkwzWMtiTkNYZO@nvidia.com>
 <YxCmTuxZzCiCRUbW@unreal>
 <6dee3f9e-f896-c31d-557c-f7a76574b41c@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dee3f9e-f896-c31d-557c-f7a76574b41c@talpey.com>
X-ClientProxiedBy: BL0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:2d::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 670e8a20-51e6-4d0a-29b9-08da8c18adc0
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS4CR/PHfiEItO7+gFJ/pysKji+fuHCgJ0PWVUUq4JnpBUdvLCv+qMWnS9QyYGwZZbnR2I040wVCRyk9uWjAY+uojMNcDUG6SmGmqtsxDQdUCNFP/rlR4KJpbtHVuut6T69Sv+16EpDXEdlSh7QIhSFPKXnO5ZnL/1HFa+ScVAoCom7j/JazQ2A3elYNSbIlobC52GL50mP8ucA38S55uIns2gcz40KMfLDm+1vsXCIWhQi37bk7X0aR3bDi8QIwKi4NOcG9M8tXVbd3fIcGb8xGim/Rchq7tqD+vcqGtzEajnVdsgNzx+TwXAYNPkpcHEZ7Yud2WvIM1hHZuH136/EGLMRbI8p1gKLc1pgeA2d46JZI4GdMScvpP4w01AENIYE+R73NRePffV3cHDxCqdYPdGGhjhEX+95ATQllNmNc7ZZuI3fKe02nOJN8A6q6xnLVEYRdp5w4x0EUs4hcMXg8Xh0QhJna4oiVG7mGMvz1TwDs2IcwGYr++Qklq3mIIdwvZW/HSkf32tBDRPaAvzj+WOJqYvKIv+gxTLXZ5M21udLb6O7s4g5R9T6plpodts+nEnCZgGpmum1p3awUszaqXkTYVLHskwG1CCtqPtGpHmjVBMMV1tdobbQQtOcQxXgtnfSpHIYxFMGGpmFgguBhoFPLdwqU8TfTG3IJLF3Gnz6FaYj7lc0fcFLOzsqzSK71Z9ZRE5Iki8zSAN3FrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(6512007)(66556008)(66946007)(86362001)(54906003)(8676002)(6916009)(38100700002)(4326008)(36756003)(66476007)(8936002)(6486002)(5660300002)(26005)(83380400001)(41300700001)(186003)(53546011)(478600001)(2906002)(6506007)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tM5xQPsjL9JTT+4ucini33d0c/4r0tCeOnk/KB7bWZKo9gqPSTJWNZJEBKCC?=
 =?us-ascii?Q?e6/fiUvOy/ns2IY0buZpOIOWv6xjOYoctnWtquijibLksQHZ87E5+3S/k3HI?=
 =?us-ascii?Q?f3ycSbAeYwdQanaur1o6zzJB4JB4nuQt+5yM9wmT4+oXkWy4pXVRtAVTAGzz?=
 =?us-ascii?Q?1k3Y4nylGl7LNw8u3vVid0HHjSRgtit6DpbKg/RlFGRdha9RgzeTKROrnKaZ?=
 =?us-ascii?Q?5yzGaxT+Ou8zN2mkVzIZnxyouFAgycShTs+xl+jEVAuzTI8Q+FQB5eLcA+2v?=
 =?us-ascii?Q?scGpoJWTnIYMcNYAYLCC/uTTI/m/qEMDC5CXS/D9YXBhs02OjK/hbYluNzEC?=
 =?us-ascii?Q?EeSEkVVi2+M2femo5+2lxqf1ONcYUfK2zy1X3FiHtk2vS5tBXd+0dBJ7zM/G?=
 =?us-ascii?Q?YF8LFoYmx3ztmpFIxdLEhhVAIfaTpZ2ek0/dK96HGuWdm1gELgXVwuAIbaFQ?=
 =?us-ascii?Q?fabrD2mii2ytts2/6OT32qLK8STdDXKL23jIgy+AMV6k9VCA02dlkECLa+GM?=
 =?us-ascii?Q?lPiH58XLKnzwffudknP/rhxPGFEKi2KLcAwOdGoG54I1q5pjSbl5iLR+Jpoy?=
 =?us-ascii?Q?BCN6/G1ph0KghiMo/xw+w6ohJwr7mbHfBV2hutm8tnDiuxEI/2J8gwrsuLq9?=
 =?us-ascii?Q?vAYtZPC7eDXJXc2OTxHyQDkaJm5IwIIXoqw+bHPtwky3Qp2ylXdziJ1841na?=
 =?us-ascii?Q?g/nj2phXxNmqZfWgtdP9v+2bx0cIou02ntAqcb9kz1hWe9I87rDhZzc/lJkw?=
 =?us-ascii?Q?A3EeUjudBzE9/L2I+1k6uUeII/9vPMhgv90v29VAfyeWfp0Jdv/YIQ1lAKxN?=
 =?us-ascii?Q?eFhSanNltNI9n6TIIr0EcyOO2KDixH0Kv5d9sKK6rQLqdToYAryuChqPoVxF?=
 =?us-ascii?Q?wY0TMcUjZRHuMhxHgxbK8AtXgyoTClKa78FPHMK9M65wQc90ZhyMqKWJ0iO8?=
 =?us-ascii?Q?1w/Yskj4cVt2i8yXx6fAUUFa4Xi1yJWKjRp/+clBZocpps7jE2xN2dGZp9KM?=
 =?us-ascii?Q?ZY/U+v6buQ/AHXPDq8joy13K5M6Rs2ngztVgElKiNNR9ZO8ZBBjoF7iUWvLe?=
 =?us-ascii?Q?hgtfnShVMCz2RpMVm4dzocX4GkuIR9yZWEYvRoAl0Z5+4RtFFVpu3iDEFHbv?=
 =?us-ascii?Q?6pVSdq1na/w4uNWiOAkBM6VjDUmYCDhG4Bsg2I00MMv0Y1c9zuWfT/C6IJHd?=
 =?us-ascii?Q?OfmPoo6xtTkeD8amb6yBhEmfm0rkiwBq4wcF6FPBmy2Yc0/4t1qCjE8tCDy7?=
 =?us-ascii?Q?2ZXX+rdGG21Q+dwhrVx8a/VF0CgYr/9Lhu7GUFr3ZAIBEIBPwVo/IFGsQREN?=
 =?us-ascii?Q?Tlyt+dEQLmxISTWhXDBZAnkadCdgI9ECpSYu1PhG4OCFzhQxdF+3ZvkNHj2V?=
 =?us-ascii?Q?tIl2KW6+TFXRjKCxQK9wfgNdXqq5rYPiSc6j/lM2by3zkqsQ2ZEZpVDOanxw?=
 =?us-ascii?Q?oMiiarRMTfdsgVTEtDDCfejyWPAKwASVLeyQ4khrOvl6hb0qgQ1yTPlyoOgn?=
 =?us-ascii?Q?iQ1BWPPb6avX67nnAHS3zenub7Mt9ro8ry2hTXxXI20sOG1egwqNwCREIPTY?=
 =?us-ascii?Q?bkVi02onbP9GALQv9BOjL5PehO2B5pL++N8IrtCz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670e8a20-51e6-4d0a-29b9-08da8c18adc0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 12:51:24.9595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc4HpoHakwcsnMMwWAMi347lMcK+vVacFDMTqY4lvTjKTpTOoIFIC2c/3ff2MD9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 08:50:12AM -0400, Tom Talpey wrote:
> On 9/1/2022 8:32 AM, Leon Romanovsky wrote:
> > On Thu, Sep 01, 2022 at 09:25:39AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
> > > > The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
> > > > 
> > > > In addition, it improperly "depends on" LIBCRC32C, this should be a
> > > > "select", similar to net/sctp and others. As a dependency, SIW fails
> > > > to appear in generic configurations.
> > > > 
> > > > Signed-off-by: Tom Talpey <tom@talpey.com>
> > > > ---
> > > >   drivers/infiniband/sw/siw/Kconfig | 5 ++++-
> > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/sw/siw/Kconfig
> > > > b/drivers/infiniband/sw/siw/Kconfig
> > > > index 1b5105cbabae..81b70a3eeb87 100644
> > > > --- a/drivers/infiniband/sw/siw/Kconfig
> > > > +++ b/drivers/infiniband/sw/siw/Kconfig
> > > > @@ -1,7 +1,10 @@
> > > >   config RDMA_SIW
> > > >          tristate "Software RDMA over TCP/IP (iWARP) driver"
> > > > -       depends on INET && INFINIBAND && LIBCRC32C
> > > > +       depends on INET && INFINIBAND
> > > >          depends on INFINIBAND_VIRT_DMA
> > > > +       select LIBCRC32C
> > > > +       select CRYPTO
> > > > +       select CRYPTO_CRC32C
> > > 
> > > This is against the kconfig instructions Documentation/kbuild/kconfig-language.rst:
> > > 
> > >    Note:
> > >          select should be used with care. select will force
> > >          a symbol to a value without visiting the dependencies.
> > >          By abusing select you are able to select a symbol FOO even
> > >          if FOO depends on BAR that is not set.
> > >          In general use select only for non-visible symbols
> > >          (no prompts anywhere) and for symbols with no dependencies.
> > >          That will limit the usefulness but on the other hand avoid
> > >          the illegal configurations all over.
> > > 
> > > None of them meet that criteria even though other places do abuse
> > > select like this as well.
> > > 
> > > It looked fine to me the way it was, you are supposed to have to
> > > select libcrc32c manually to make siw appear, and it already brings in
> > > the other symbols.
> > 
> > He took his snippet from RXE.
> 
> RXE, net/sctp and many others, actually. It seems backwards for a
> subsystem to depend on a library, shouldn't libraries be there for
> selecting? If that's invalid, there are a LOT of subsystems to fix.

kconfig is a mess unfortunately, and the crypto stuff is kind of
weirdly done to be both a library and a user selectable pluggable..

Jason
