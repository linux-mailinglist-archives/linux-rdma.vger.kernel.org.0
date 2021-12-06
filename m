Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1161646AEA4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377612AbhLFXze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:55:34 -0500
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:39776
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358010AbhLFXzd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:55:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/ktcf8UN6Rotu4nE0LfruOFrs2wa3JtLRRdGQ+zGFFEvM/Ta4K2EOXRlrfvrCppVLDjC1Gaq4uEcqbTYAKDoHkj94bGzbsWI8/p4kBHHSdDB5mww/OF3377TtvngwQss2FDxv3YlL3+RC4qdlkD8Gw7huFyT1PYqPhDbMaLTkrUwJZpkOrWarwwO0A1MoW9/IkUltRvhTo/Lyf27I8/2wVloD1O5iwzWOKGEAMU5jVzCGcqWrzp15fZbKvIc8E0rg6nddOehgHxJUF1t5yQmUrDajFsGm3UynYtrjnOJ0fLW1HWwGJW/6ZZuGe31N1OHEMaqSCbJZYEhtTU2hynzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0B7tKvfakorjjIuyP+5NqWsQiMJE9krP3nUbdx5c3o=;
 b=gBXWesefjdgMwDyFODifhiFALphR8chUp2a5O4wrvNTkV6EzpTP82XDJpiMJ2+EiJEVpoHZqMEB6AlxuLick8zCVsyLaYcxdfd8aLigBXbqfhauByObHiLEpAIvBXMgnuFsmaL9GQXNbDUt+faGA5pb90s7V5039L+u8LWazAaonaRg2pvpo7LO3jtPlEzXBG/y5lvt2/WCVIgl0LqHA+1V7+hck61vtj5FoOk3vq7OBibOEbEaI3hEqRe+zrdoE6O5bt5sOoSA3Bqagn0/S58brK2gCQpRNha1OPCP77Rx/LupSjfqlk0xD49YygDuEzpmPTNwoT/1g+KSaolMHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0B7tKvfakorjjIuyP+5NqWsQiMJE9krP3nUbdx5c3o=;
 b=fRV2bGKuHa7BmeCivkjSgKC51pFp0wAnf92S+ftD9xNQUT/XoOkj5wFQMbjdYVsjOTuL9I1w2QcGYkvAJrBBOD1sDR5lHLbnBRsAwJp2C1sm/cXeE2B0HjhWbKel5qL+yY21ecIXTYC2a4s3pb6aCQF+e+dkqNory2LRr43INgK93Jci7XIYK8SAUo5YxwXH6nuOZSO97YJJVNLR4C0oO1wGiDodkL2ZdlBCCIfWahDjoYyg91XyCbnXWOIN/hdqiBLy0Ff1zNUSeZk41BgZBJxHR2P+LSR2DgYBOsgD2NNftzeiWL3p0AApRwf8v2xWnWPavNp5YQNNn56STXNcVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:52:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:52:02 +0000
Date:   Mon, 6 Dec 2021 19:52:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Use max() instead of doing it manually
Message-ID: <20211206235200.GA2170341@nvidia.com>
References: <1638439679-114250-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638439679-114250-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Mon, 6 Dec 2021 23:52:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNm4-0096cM-Un; Mon, 06 Dec 2021 19:52:00 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ec3418d-432b-47b9-f00d-08d9b9136641
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55051BDC63C0C1D9D62592BCC26D9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1LYe1PmRSWslYcEOzqm3KhlMFircJfdMOY34ypVsCinjWedfR1mqcvPVBOwjHfPV98y5WVaw59Xnis1vO0d20mhf4L8DEg3GcF6fn1wiSH/pj8edtV/JBegmtdOpjBq6t7z02IM0itWM2yTYXSYG+09oEs4tI2bdosaCNud6h8BsW3obLUaUlSjfo9vp2QE79t9wOipokVAdCL/kclUrR0nC7tkQwoVVOuuwzF4jRVTQE+2fBS8GoaydymthLvm+usR/K9CwTtRw1RCHIzdX6/fgqEoZDgkluAFhSgbS/J4OwuECeO9klUXGJFrDfQmns+92dtALRSbHr8GIIdBQkEo8FO2B4DRpvuzgaFcgCMUVeO6vxx9v4mD4wKANBPqbs9Iaenrb3793vnsM1buVmhyd5tJgcvxd1u6fxsqUwXV+rra6X8icGRhdRY+PpVrE/G98eseDD4AXhTWBZxNv8sA5Z40URHRdu+8BqmbRy79ftNV83ntL8iZfDRPdZEZiobrt/IBY8ZWU3bLjhrXeaZvxdH6TtyaEeK+j/IP0Y4osTmWxw47ksVR4bW6DLixlM8ZD2hg16bbc2zZHzvFPtKH46MY40qhEW8dC4erAyGSK+blz4lh4RPyzzsNXDUCAeieHGFcRxsTSZRQVtZpHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(38100700002)(186003)(5660300002)(6916009)(83380400001)(2616005)(33656002)(4326008)(8676002)(26005)(36756003)(316002)(66556008)(66476007)(66946007)(9746002)(508600001)(4744005)(86362001)(9786002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8o9U50anPpnnchzLOLhbyLx5zfHPKKmBCBJigRoSsONx2oMat7h/lIqLbyIG?=
 =?us-ascii?Q?gr3fD8f5vDozNvkmpNxNV4PeFjpmdwS+nFJHdKzS23OvveJRwcMq0Uk3wSVc?=
 =?us-ascii?Q?+iH9Z6fSrOh6++eFhlfZ6eXT5yH3ICgFtBZ4zO/80z5+IFpmVCQOsDkK/56N?=
 =?us-ascii?Q?6udOghtY8lMNYeYknaA/AQGv53AyChz2VwjXVI092xGW3Uc6lq8CB94Q70sL?=
 =?us-ascii?Q?DiZPf3Ud5MaIgiYkb0h239ZTe34Ofq3R9OK74Pd713Bp8/ccOxW/JtzslYxL?=
 =?us-ascii?Q?HhifVF4LkOhkCA+MYJvoja5AkDEJ/qhyhflMxdTpky7EuyZ80s5NdoJUHkb6?=
 =?us-ascii?Q?QIyzu52g7aPAg/v7fpZ9IxOLgQ9q8jyvbxS1H/Nn0jKdNR6yOmJ+N/4DCF28?=
 =?us-ascii?Q?SP/ztUiMMBVJ/akfWmVyY+CKWbmVZ8ouNAbhzUghNG118VZa04+J8TmfvvJ8?=
 =?us-ascii?Q?qZUbz6b1+dRz8RxljphJpLemfcCLBkD+DhYILWH4vtFXqj8LmtnDKWLxe3Gj?=
 =?us-ascii?Q?MRqvOYkQwbtjL+4vmfbQKNAL9GCK1E/DneIt6Uf6pD/LcHzYKA6G/zqEw0sg?=
 =?us-ascii?Q?DgvvsmcEIWYM2nSxrxR3DcVDCD6LmZqQUzxNVgsRCxPlfYkpqQjc4JuJc6tf?=
 =?us-ascii?Q?uyhTtROSvUQa/bRU9mxn+0o5jOsvZWy39JTaBO4AowJO0dmtK856slc36TJb?=
 =?us-ascii?Q?82gvD3LgpanPyv1+UkU6OHZmLl+X9l7yWLgY9+5yyDuKyJ+zUheoeQka30C5?=
 =?us-ascii?Q?w1YqXv8Bz386S4eh9HPYtkmy1geSK3MS083Y9dYqCGM3IDOPlOC5DwYOwXwL?=
 =?us-ascii?Q?0yJRwGvJNS7O3fDwML5wz2/76ndFYDOcD/B9yafRzC+2iJlBW8a0Ge4f9KIb?=
 =?us-ascii?Q?PP2Lf/YvBLlRPUUMPsvpHYzjPGyRIsWCsWhcXmIwklk8yEBA6/Z/cIIIXePk?=
 =?us-ascii?Q?6nko28FFHJ08GalcvidSg0SjWOL5GCcBXTKMJjL9qWn9g9+1D8g2oixUaM+a?=
 =?us-ascii?Q?JzQG693nQ9e23b0rZni0I7jnaVszG99dETsVVa8brY986fHu1VP4lO+ptF9C?=
 =?us-ascii?Q?B6W2EBZiRy1EhYyN1AD0f5PyovxfkZzWCM4TCzD1T0aa01mkigZNACipJsRI?=
 =?us-ascii?Q?cjHpOHiS9gEMbfdcIvSwPLi8/XQf7ROdB/aTG8rdYJ5Vh0JGUek8ONDMlZ9R?=
 =?us-ascii?Q?lGMJ1ZiqsL71NzXaMsYB4CfdYahAyawm0+WXa840SmHd/PrxQinh43sa/KeX?=
 =?us-ascii?Q?6/YeK35pfJW4yc1p4WDNxosutC5Nr5a0y8IWDA/YQtqDTxbLU8fRE3FQHevL?=
 =?us-ascii?Q?TRYyHlR6Wvr+4ll5fON1bM8Di28Ne6xN2E5R4whtabsvW0bhctCN+7eND4bE?=
 =?us-ascii?Q?v5dyAJyCluwCezkjw6nX68sMJPy/S4k4ayuWnYlkZx7x0mDLBthKy6tJan+f?=
 =?us-ascii?Q?lTiRDHmOpVtWK96Cabk0pWu4On3lY/sd+9wHN5VotONE/n2SdxPz889oQHMC?=
 =?us-ascii?Q?ElL5krDePE6vz/z1i50DFiZqPBW/FAYshHF4MhOpQOValR7r8bTJTtb/n/u5?=
 =?us-ascii?Q?TLN1mkA7+yfUJjMFnRU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec3418d-432b-47b9-f00d-08d9b9136641
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:52:02.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjANYXn+ZsKOdmHvyQhfFMQ2P/IshB4IHgO5IMB9zB99yJj599zKNnCrl6l0xgpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 02, 2021 at 06:07:59PM +0800, Jiapeng Chong wrote:
> Fix following coccicheck warning:
> 
> ./drivers/infiniband/sw/siw/siw_verbs.c:665:28-29: WARNING opportunity
> for max().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
