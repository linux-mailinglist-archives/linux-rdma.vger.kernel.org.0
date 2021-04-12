Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5151935CFD1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhDLRvz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 13:51:55 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:38753
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238523AbhDLRvx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 13:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOthsYR++tIfMXMUoK3yqm136Lkx4v+wnn9p9o0VDJYjr6V+2fcci17gNUkADk9ahFJXaJ4dToJKosy+1WLDs1oO5AomdggWbztJcOBOhJwSIIwoRv4TbPKnFLqwhrlBeBAMjnlsZs4PhYJBlJaC/er7d3io21KDbB1MfjfZtwCjVfHBVK384z+YW9I/3+SV1h3MhQIdeCekb/gYh85JOOtz3PEb1NPcT31+eQJpa1RLDrP/7IcsB4fd8JZK3NoKlgzVW/3xZ2IhGy6youAZM4wu/MRaxSmJcEMhypO5RkMky4DF341UK/uqkstygP4+FbJa5XpVH+XDV/Ns/bKLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLkkNoXc4Eap30dzjMTM3xsLg1hJx5RJr3wZsZ/ufas=;
 b=L7nu9V7pOtskDmT7W0k2Xk75aBqyr9bWxLk9NqDUmsWZTXyctBzmWnfNhtjF8K4/uU/jH/FtgkqlCWSOJR+E/uinJBMJjkHSF6kXaVyVzCV6c0VWe1ZRCOwAJPKwG0dcAzs2lu9SrxzXG7F4qbyuMUimvNkce4UQCvewr+lvHCEaecuWt/TsLewonhEtBSwt4xoS3kvPtuSpeC6dOc2i0iPiDuhqTwNDidETZqza8DLaAp39k94eEaWnqzmsS1jVGlOHT2YxNR3G2pZeFkaOM5k4khwB/IGVblO73o5QFcZyHiPDQpgoyryzoOi/1cQv+i4bSuqvmzmUSUpZ9HNgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLkkNoXc4Eap30dzjMTM3xsLg1hJx5RJr3wZsZ/ufas=;
 b=aBkecXX5FYxyT1izAcfDohV90H8T7mAXp3jl00av0wTefNvMPQHLv+fDemVsrCwAMC4CcmS2CbSFaUMuP13L8X7Axf33kR17eI2/oDAUxDIK2oOoBhwexl6TT+vEI1NX/2RcKUinyqW3NDXmU+2lsnxS+tXC+cXwde19Xk8bOcaIQOSD9SGoLRpINa8VDq5t515JWWosGjzb/QsFxvFsBVjP6EplPd0hD+0NTyoEWHVTCUQNvw6p8OsArYmP72jtyyiVhfQB4gzdu1B7+tGICFHx0N6iszzgrfRXQaJJ6D9b0H+Iu68Mk4E2jCzhwYg8+uaCHYhfikoOtYxKBconyQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 17:51:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:51:34 +0000
Date:   Mon, 12 Apr 2021 14:51:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/7] RDMA/core: Remove redundant BUG_ON
Message-ID: <20210412175132.GA1140114@nvidia.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
 <1617783353-48249-8-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617783353-48249-8-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0402.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Mon, 12 Apr 2021 17:51:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW0ii-004mbx-Vf; Mon, 12 Apr 2021 14:51:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65aea93a-5e2a-4db9-c207-08d8fddb9cac
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285857F41E113EA1DD803D8CC2709@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wt2U7YQAc78lJ6BQBWgoECHV+vJBkGFfY3ryW5WsMJjrtiWoiT6rpCDSEl+NcIyX34x9Xvf5CpAzpeQl7F42GlL9J5iYRFGUiM0xR8PwpthvbxBuKH8+vwsPp772GB9uvOENHbXERCR5nMHD5ILpSfoJLks6Oi6y6d8gR6SsZg0FzQHB15Dm2egiXOUy8JCVg2esG3t4OnGlyWxFnNa960fH2BBuiJqnANfN/rS5uZQC+SWVXfW+JU7GHNyQxhW6b87+1XG8ylFW+fE9u0RAa3czBBuC0my0EzOwxGBLCBE6+NuvjOJLrIpA0zc7ttiSqHN3njHvNp1uxeOQjiCIdX9h1MtiZELxmnQrt4rhaUdAMWWX776VuUtze+xduBwPRTh4ahZjE9O5sZMqmTLPOpr1qoTxvxx7VQuGC5jjaB4TxDVce4nKH72PXzqo494O2u9XxvCJg0VsjTarMRZAePX7POS0wJjS1IEHtTrSXdBMWsw1keCFWVKObwVYHW2dPxgQMr5LSXg41D2bEhdzTZiNf8vqj9sQFMaVnDkO3+A3caTwfP68k8fKXLl25OmOiP7ChYMy2kXAbHeOoIU925KP1f/Rw+oFh2pTgkpM/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(36756003)(26005)(33656002)(1076003)(478600001)(4744005)(316002)(66556008)(5660300002)(426003)(38100700002)(8676002)(9786002)(186003)(8936002)(2616005)(66476007)(6916009)(66946007)(2906002)(9746002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iwl+s5jHwejj8oNAcFbt/rWEXRZdZ4ns8mo6GH0auIk0xXhQ57Ew+0xHBpsz?=
 =?us-ascii?Q?NP6Y04Ek5Dn9zRYH1Pe6100OhiwTJLLb8S2UirgXzb0L+UrojTlOhbhGElJt?=
 =?us-ascii?Q?FXpY+k4x0Beq9RY60EAM31+0JHfRg4tmi8lzHeBxESQ1uqv6Tv3kYCWmx3xu?=
 =?us-ascii?Q?csSvwF8lJ5lsdGpHSpaFj1ZsTEoxfA7QCO+SbOqXeaVLZg7MpVnBD51DtI9T?=
 =?us-ascii?Q?M/hL/4cDPmixEndJhxx7i8Zxfwxb0f/TcTTy6kW31e0AcIPkQJPl7wcTubgQ?=
 =?us-ascii?Q?NI8ninfMQYQIt38UmcJFNdu5ZgB7HIWSIm/yoT6D93k5LPccqLtU+xsvGscv?=
 =?us-ascii?Q?8IM/SGFDsaeVql28s46FliV1M4+5cI2pgvNZv7f6xwxX7m4Th0DW19n/e1+P?=
 =?us-ascii?Q?oV/3a8mCRRqtw3JssRTTWgP3iu8u7Jp1IfnSYfcGnqx88sGunkFA9mA+RzgS?=
 =?us-ascii?Q?SWLGS2+s0DBus9uoGnvyeS9+taaeoHH7gIZDqvQIM7QHUszEBTr+NSgW1B1E?=
 =?us-ascii?Q?cwG175JoNMOhiqIJ4lyAA7vMmHImJEZvbU93CDdbJnjafEIYIo0iNQ4tBSP3?=
 =?us-ascii?Q?7+FTbn1rPOs9OpKw63NcsDyHBb3W7ibfzYdX/p3rP5wqAXJUZL+/D1YiwdFZ?=
 =?us-ascii?Q?jEpnKNKpcAGuvCRzQyVPZGWI06h4P6iKdtLJ/N23Qf/YH03ziKwRtlMVLhlK?=
 =?us-ascii?Q?FTdyy5P3RU8rdqM03Lw3zasJtwMTcTTK6uN4UXET52OR29Foxt8BH+882Ilq?=
 =?us-ascii?Q?aCwajvnBlSajZ2beokPn4hMR2ffaFMkBte6kDY8XUcTmfM8exQ3yGyYkQ9cG?=
 =?us-ascii?Q?Nday4eyZKCXFAqOiDZeu8yOHfvmwsT0wdLeejCWMiU3rXYuxSJ6MXUqXLKec?=
 =?us-ascii?Q?tSe/ft3MA/0y6zrvL06sKDwlmHZmnGNINVXGvDegXFX0DlkMNdcSjWsy40mS?=
 =?us-ascii?Q?WQQyY7HJhBn4rDWWNhhO+p5UxYpECE9j3Kr2dUD8O5rY/4fWnRKYtF9Z9UGh?=
 =?us-ascii?Q?4thyITwdkWS++YtxRjzMNP6aP7+s+VnAMVLIVzoXJk4oWOfhhr7puRhYO15n?=
 =?us-ascii?Q?vHWlesnVBmW0m7USNe1rPY52nYG84QY1SUHyKHwjpnMXXSG+DilrnycV7wnv?=
 =?us-ascii?Q?EHN1Ea7JZWIWLtjzOzkth6ENoJn8Xky7ELcj+QgkFUlar1YJBIxmSpVPos/j?=
 =?us-ascii?Q?TQRIE8UR+VxNUN7o2B0ln2AVS1dlvFAQJYz3+ijWHWB8glq+LtqPAhLmc7Iw?=
 =?us-ascii?Q?jDBR3pCh1YIsOUIlU3wRU810XS2Tm3+zMJlqEp4APJ/4ai3pGgcgOASqQav0?=
 =?us-ascii?Q?SXA1b5VPjbLlri582+FhcEVs1q0iIrUSbIB2ZuQgjsPm6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aea93a-5e2a-4db9-c207-08d8fddb9cac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:51:34.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy8Sqh52vnXMKS6/l/Neu59PJpF8/UoihGbAXnC1W6I/mVvr0FDV5bD0k/mgLoms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 04:15:53PM +0800, Weihang Li wrote:
> It's ok if the refcount of cm_id is zero when release the reference of it,
> there is no need to call BUG_ON.

Huh? No it isn't.

If you want to remove this BUG_ON then convert this to a refcount_t
and rely on refcount debugging instead.

Jason
