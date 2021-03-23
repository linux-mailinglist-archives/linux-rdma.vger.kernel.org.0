Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA5345414
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 01:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCWAp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 20:45:58 -0400
Received: from mail-eopbgr750048.outbound.protection.outlook.com ([40.107.75.48]:27105
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230166AbhCWAp3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 20:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+SQ2TAdWOj996QO5xnJgTHn+4jG7tPTKFYj4Sa55aNXOGNlvogz0qOQdX8Ki52R1TiZsGsJLdA6yD9VWIgKJ5Dhog1MvfQYHJY5XFnMM3nz+s8otCCxjswGYAJi3ede7r79OIfmPVAjjQayTUDokf8lCx+OIPyAM21iPn4794vQdMODdCMuVaRaazwBKnJeMZms2rIinjAJp1XMmv2/ChMhtWXr+9UO1+BPOQYOF3uCpO5Nt71DVPwCIBe6LcJIV54fAM4i73gEWCqLjgvfn0k48O2mvwn5FmfxLUDnTdazqYNbk33Qq9YwUy6G4pheq9bKY2SMwfuCX+E1HH3u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy9uTvWlIW+VxzlFxnl3wR4v+OxWwH0RMlRRrzq8Fx4=;
 b=Ut28QI/8U2NqTzyn9eXYIqHzZjrlVV9F6wtHJ+7nZWy4COauDibaB585FVDn0CGWBbVNSuLm3e2/kpkdmrn+KkqM0qh1tNRSm7C/pmESZX+ha02TtdW98KgY35PHWtXcYM0ruJueZRQhifsi9NSzJSsfBGQCztI90YTOviPJamQifxJXQ8dUR2eXTMgE7MRx8d8aCfDTwtVIklj3gdW5Mik5qOg2GKQo1yPDyuoLhRWtXIphyo+KP2Cvh4SZYApBnlM/efQntHfR0YzY4a/3E1v2V+bJTnkm+HvSVzCRpkM25TzjyFgdJaGqz4+k7HjzUq7DVFLtYnCWjQ58MRJLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy9uTvWlIW+VxzlFxnl3wR4v+OxWwH0RMlRRrzq8Fx4=;
 b=GQjpEIjwDCX7S2/Hny+KPdohCdnhLDbIxvfE1rjEhkl1oZ+HxoklV+nXWutwfm0D/gFKSzhk7FIx8YVAfCVF3ip/xihJAfQ/MhzOKA7DNUjBBOMwqVShsXJkvP6VnRpo+hnqNkbReFFKUlSFH21BTLyoaNz3qAgInBL0kLTLEqmUbV0WgoKtJHHr7qYdFKcO75ygmycUGwkSuwUXPfO2przXlDHuieckks+J/lm7+snGQHcC5eAigBwZPsJqLdZOG6Q1hFnOE5k4RXSoxnL+iynbvVI0JzBHyhbhNUd+0tW7DrChkRFNEAG3hBuhY5Y2L1A77l4LSWAKPckWIyIppQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:45:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:45:27 +0000
Date:   Mon, 22 Mar 2021 21:45:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] RDMA/include: Mundane typo fixes throughout the file
Message-ID: <20210323004525.GD247894@nvidia.com>
References: <20210318100453.9759-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318100453.9759-1-unixbhaskar@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 00:45:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOVAj-001HY8-Jj; Mon, 22 Mar 2021 21:45:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b62b19-ae6e-4777-6a54-08d8ed94f3b0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02030CAEED519B6DED8D7302C2649@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNOTzUfDN/3knHRSu2awVtxPQYFOdTrI2NzO5eRGB4cKH4VcECGY+UHVWuH4gen4L0ik4yVgkumjN/uPPjRSt/0w19gpihvXr3B44G5AzHvaUL2LEfV6gRHeH7/rWxxg7j6DZk2zBMTv871T1+H81Xd65iMgnozBLK8RbQyy1mLXRgHeOzfiR2wtcEixPYEitKb0wWYXcHAawRi+KX7tf3bhvRNLLKrV5JArHrhRCrlnnM8ao8HBV8J2yEmVDSTkblBLPMVc+APio0ZDTEHCIU02VZQklXyIHH+xLb0tDjisngVli0Gke5hl5/sPlQgFHUZSuKptHyxmvWHaHfsURvKX0PvObBQJruXHfV9HrjDevC+Mc2OGZzPA2bn5Xpthz/1GwOImMz8FC2CzYyUulDPFKrsFmPdlTjFKQupVJd3LEmYi0j6lYsM8MjoA0JPwy8yo/S2OEOO2hum1phxtAGXYydAId9O53wpZFWv02xO39x/WZRBH8xqmR9EnN8a/9YoicZ1GmcJOuKuwcBkx+/AeAfwxjugW+wn3AZoisciFiPCSIHITo6heDagY1QIH2sGI3rD2TeNgqAKuPFfgJ2rx1Zs5g8lcf91g9I43tIVxN9r/tXn58WtBdIO3EVQ8uvxosrYjyy2NUnsM7NnCdrZoQYsYW7vw8ZSTHcZ3Cgtj7DfCmLiohI2dSEfs7puz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(36756003)(4744005)(33656002)(38100700001)(83380400001)(6916009)(1076003)(478600001)(316002)(2616005)(4326008)(2906002)(26005)(186003)(426003)(9746002)(66556008)(66476007)(8936002)(66946007)(5660300002)(9786002)(8676002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?StLO53N6YHhc06haiYyPIgkmlmlWg3pLFTdT+Yz2PuOGj6jLxLvkASq0rGfc?=
 =?us-ascii?Q?Au2V2m/8LGYCtWBfcgzOECkzSg83yjr2xCOoQExX58YIuvpzHQZPNLd80l7Z?=
 =?us-ascii?Q?b4022a7Q05mn1aevcMhdQROsSqQeZUYT9IXkBy0URZSp6UnYrkevTeqBnOkq?=
 =?us-ascii?Q?6VIxUZuhzl/DPTdHOSTR1zT4Z87PrGrpzHmoNAgWhIDszMmFLOMBKxyeUF97?=
 =?us-ascii?Q?FtADhet6kGcDTrjO06XUXWvmMSipeF8PQa5V+B6FO3GzQcT6EYAzq/zJF3Dw?=
 =?us-ascii?Q?bXKwrdXpk7Vg1L7YyvTmnxHXhkMTuXtA7JXKGtMTiDmt9TUIkkv/eJijzm95?=
 =?us-ascii?Q?Lkpvy3eTfmZlqbuQjsC0kvEin7L3jzR9dW6CafWc/sVjUqkls/V0ZP19KNFE?=
 =?us-ascii?Q?AnAts9v96oJrGqkRw6Mu/XOtzO8EcR2/PdITxMhza9yIHeVZgnKmFcMTvAGa?=
 =?us-ascii?Q?pFgqd1A6uM5HHhxFKH6alS2jYFCUsUPhSmcJj9XV/KIfo5/xHz8PeaBDDU6m?=
 =?us-ascii?Q?dPR4rD5IllFoI6R1qOCYURI7YnyuLNUuifvu/BYG7qOj6O96HiPVhTkVSXdI?=
 =?us-ascii?Q?P+jYdKoFcsYvwQK67RSIBID6lTQck5tRDY9XeZnFeNaQ9VF8E+72ZYCuerLn?=
 =?us-ascii?Q?Ipt0FLXgdbGqo5LxTEJn0/NCsSlcY3QJjtaJYVLyHRBoWI1o2mW3PV+kDBdw?=
 =?us-ascii?Q?Aco87G8PaVcyE6tUvALkAGSKWZ0QEzwOsFFs9nXGlYXfMdCl5woGaA9/0HXe?=
 =?us-ascii?Q?9EOXGm05UUf8Z1t4VgJtAUg+EQ8RRF+kxn115YqOl2Ktfb+xgNLmOYM6CrsZ?=
 =?us-ascii?Q?jK+0T7bhaW5WkJfiLXfsXMI9plblPMhhAseWfbydNaBzdufa05TPSgsvSQUZ?=
 =?us-ascii?Q?k1OhUiG4ttN3SgsV3cQ+/B9tc676FhqbimsjQsa2YmRr/Ow6b0OSKLzz914W?=
 =?us-ascii?Q?KJWM+6MqSlkbdC7EYX4r9OZRJx61c/fXjFI+Wt3j89/nC2KrSbJegoqCpXa6?=
 =?us-ascii?Q?0oBh9WwIChTXCmzUfJ4gBI6KkDn6Sz61ch8957fo1y6u1HqQdSTwoBFA2jpN?=
 =?us-ascii?Q?r7UayXTeZ6U2srM59a9w9Q8ChXEmGdxpOI6D9DCZu6SXuVKm8nDkAbfWDIGK?=
 =?us-ascii?Q?+TyGKHqib05MkhV/Q0jAwQccCtERXeiTY6ShwcupPz/ML7Inz9p9WKOZvG4P?=
 =?us-ascii?Q?ZXpPdH/8O+86qVzzofRqP86VzEx1eY77FoipZArz/Gg2FxxURFfwrGa6kLFS?=
 =?us-ascii?Q?SpU0/CNJRDoWaGDnkrVNk4nWI9UenahwvfSo9Ri2an2MA/PGTThzO/x+28z9?=
 =?us-ascii?Q?KzMkeoDI9c2/iigB6C0WWVNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b62b19-ae6e-4777-6a54-08d8ed94f3b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:45:27.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1whHzFmOmxelRKgKex3Ww3pS1WavtmAkhtXifyt31DfbZJxDyZVtldgY98Mi1lHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 03:34:53PM +0530, Bhaskar Chowdhury wrote:
> s/proviee/provide/
> s/undelying/underlying/
> s/quesiton/question/
> s/drivr/driver/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  include/rdma/rdma_vt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
