Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5934F4AB
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhC3W4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 18:56:11 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:10912
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233072AbhC3Wzm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 18:55:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEPVQQvE/k/+/MQWrJpYfe9ooE3OjWZNWKIOcA/NrZnpSZJJX3ec+/nQIAddgwKr0e0mc7EcPULkESxluhHcfvJduAzhk89rtNtEqc8kTxybttyb3fSVQKXyqvJMe2CR9CMdDZJ/+d06wZN6B4GocY9uyecpnpVpGpLs6gKMziHwpSo8Onss/3/x8VzTr5D3PSlCAuqHLzYGbv5Xjs7F0hFKeQrbqw7CHoFOOzhAm4lLGmXx60io3A3mo1Cl1Mra4CEMDp2D4BOSHldlSQmKepVCzrkPHlau8Xw72jbH2N8OXG7fq3nYcQd6JUTqE8YFDctKHW52KUg2SGaBeB/RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLI9soXcvYKqXFf7kuSSwEs82E3puU3lmVitEEJzagI=;
 b=k5UwLLmdn8fo0EsjmcxrspdaZbKWR8BddPDPKSMIS+yiJK008SV6vRERS4SOg7MC5nltEWV5eL5lHkmnrTDy72AvhSVNhwDTQBlzsMS6l65KRFHyX68/t7FwUqNBTYfq6woqQR7J7bwihw6zRPJxeySukOJdvBwe4MZ1lEcuZFw2rNgYQFTKK4obl01wge4BwMIDJhGkM6WMEx4kpfU/cyNxgcwcqHUf8rdnqTpwW5OvcI5jn0UHkRZMvMUaakQLWf9X/cxyREBZht2HCZJLQm0mqaMOjlGIHBEd2mm+WJ/eHKMD043JVXGvMIMRvVSOyPrHpJjyVHYYflTJgy1cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLI9soXcvYKqXFf7kuSSwEs82E3puU3lmVitEEJzagI=;
 b=suBEsGK8IygXs9y8bMvFM5Ov4fHn6qKNnvlW/NYNw47i07QUWbFzJjS1D1LNzXxOzXk5fSyyAOxWXU0lDj9n3SFdq/dC87/5LA2757N5s7QZScBwy+JlmP4dIdGfaKv8/UdmjWoM2FDcoSYLRt/DrSo2WClosqpi2dtlKcvJh28MjcxPEP4fzEtdFlzpeBQaI+YYdu9ldlWOifyNK/puieao6qgxqREr1hMCr5cUmJXQcym0eKrcrM9bUZgVtf4o+JUTE/3JFMqm/SqU0/ZLa58hAbHOc22eA8I2isgwnBVeHe56EcL1MlJmD0jVRjY2AcZKRFQY/+5V6XQ9ZHOevA==
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 22:55:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:55:40 +0000
Date:   Tue, 30 Mar 2021 19:55:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] infiniband: ulp: struct iscsi_iser_task is declared twice
Message-ID: <20210330225537.GA1463613@nvidia.com>
References: <20210326113347.903976-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326113347.903976-1-wanjiabing@vivo.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:fc::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR02CA0009.namprd02.prod.outlook.com (2603:10b6:208:fc::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 22:55:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRNGr-0068lL-J8; Tue, 30 Mar 2021 19:55:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a8b380-addb-46b8-0498-08d8f3ceeffc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35141652F02D6C1FB8206236C27D9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTYZdwObZRPafIuhZVpiVuNNWnQku2TineAduol15cBCAqTTDaZs/+O9JukP+zHmz3deEG03FO+rlglnZdBQHGcNPA+PZjNhABtkBYx886/TowW2m97liHBa5f61mDn1zs6X+CqEr94aqvWzi1DiOkZtGxTdo2HFwkQSniJ3aV7XxA9Capbr1Xx3JVUWBZ8oPTJFc8jtPOUxFWw8f5YEEtsCDaBKO6eB0ZLH0FVBfLj7VwGkqAbe/PhWeTZ8/1YhY1a5u1nkw5WyiGg4+/Z+qRVmZsYu2+KFae7IZGK1Zo3cQcZs/r3AB/4r19TykwLotHhtp0X5m/P6Mwgz1084XaebqNkVgSP/Hh3dxiagxb/kxWHjvQJQ0fi4sEQIHXUnj6O4/tAxb5mnNOwkE8ber6ox+A37M0DccJzHZ0v8CBcbkjcim5D94Sw+4WJud8gQDASUkAxANdQDiqnWxSESOAqOjt7EFiv0n2YtA26vzT6QIQjabWf0pfTvb5MU+p6Wq5DMQcLyvRCTZTXy2tjjkitXS+YxMXK7Dw2HOucapHmJkkJ+C3bVg2AS/L32xEtBdjd7BgNK5pGExm5c/3dR0F7hfun2nyZbu22LORJNjbuYp71Vp0zlE05GyKl9ulthwgW9IHv3reEFadwdjQ4m3muYvglBqPwlL+rfcT3HQIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(38100700001)(4326008)(83380400001)(316002)(33656002)(2906002)(54906003)(66946007)(36756003)(6916009)(4744005)(66476007)(26005)(9786002)(9746002)(8936002)(5660300002)(2616005)(186003)(426003)(86362001)(66556008)(1076003)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?twQZEmcVGD6nUfv1r2uox8y4AfJFrfBPg8haNq+u8W4NZkdu3m6kpA9Jn0Am?=
 =?us-ascii?Q?9sC6gxko9nB3504qgLHYKAt1HNGCalI9TInkt5N3q22WQQU11WRvbBtgnvHS?=
 =?us-ascii?Q?fNRQ7f6SujMeg1TTbpgnDtMj3dUNmSVMrvQmdlMDjiHg6f9qNLFeLP1K1mCv?=
 =?us-ascii?Q?dcTwc5tmxW+Tht6Le5wOJn5Mp55ORCnqwuo1DeW151llk7ckfyksApQEOrXd?=
 =?us-ascii?Q?yCAVGNPa3QPfTXyboPZNQyGVgp7KJrmngJVZXCmC/5JVGGIQ3S9vEewTvUn4?=
 =?us-ascii?Q?0/1KYfv8JVKmX1y7lhF2Y3LHhPKSH+2PE8MnERJZyzH2PPCEPbgL98piB6Bq?=
 =?us-ascii?Q?LE8gbyZTrcAXRdw8E57VJyaf/H0aOK1fS9VNH5TGS2S5rzxVbRmCB7yCPXV7?=
 =?us-ascii?Q?ZopbuMSNtqR6GGzCzQetqONpvjzAVjPOl7fCqQMfHI4ZmaP/u8P8kNbfntDY?=
 =?us-ascii?Q?0+3/61Ak0Vh33145u9F7y4Ne9m3pEOr26i1IFk1kBSz/BCpZ6izhZpzkGIic?=
 =?us-ascii?Q?+cJTI00yY6VkOt8Hja++meJe/joniEkTIzaTvd1NCQ5hjNn2O04TcOxFMkn1?=
 =?us-ascii?Q?0toHqznuyKQgjyfchQXf+OdRBcGiMNSO+pZ2gSAjaTZGTEmHgli2DzeSP1Jy?=
 =?us-ascii?Q?zRNHST6TNDDOu442sOf9VqV70cV6ZbjMrJYPMo5Ad4NHcG7NSwBsk+XD0f6f?=
 =?us-ascii?Q?2xcFq6IWiar2QSl+IomBlO+dIGOAd1V5AjNWLnD9WSHesn4RTaUjQgrTkE1o?=
 =?us-ascii?Q?fsqR9cpYfvRXS4n9DV0Q+yUV+zIvtB6TMLwGjMXLlzBCs+rFu3tOaKN+H20l?=
 =?us-ascii?Q?p/An/Lyc5DkmKEaV2qQC83f9D3mDyzO4m0yHauM3QVH9a0zkKRJUKHVRxvYO?=
 =?us-ascii?Q?KLMtr577Ayg5RU4arb1XB26O3YVKN6PpULIjIiUQyAApeiMANsauxofVNa1+?=
 =?us-ascii?Q?iijoyqZkzQ6VN/5j5MDeL9d7G86VT2NKu+iY1/6W6LN7Xf+vzcymtbyyHJkG?=
 =?us-ascii?Q?U9FPJvW/hc4BBxAyYNURlk+NbJatgHIrVhCR10/gQLwqnMGIqO7UXhxG/4n2?=
 =?us-ascii?Q?jaJv1K2PzoIRgiKAV1RWBBOdOFx/PASPcaddHCvCOV5FHkuj/bdESavbXV3P?=
 =?us-ascii?Q?3szQkFSvG9znx/cMYXccnpVE5pR43mieD2LCn/NHg8cNDMPDgR8P5Jdtpdyq?=
 =?us-ascii?Q?SMPq7KfGXCrvgjDymazLWwy1RUKWi8RDBTW26woJLZCqT4v/3hmLBSlp79C9?=
 =?us-ascii?Q?JRR8bF0GM/B3+2D+BV8JmCM0lEJEwFI0cgDO9ODSX7yxLTg6hWd2uw83eW2i?=
 =?us-ascii?Q?2T0qKB/wvv+MRWhE+wU7/79kKxPznT13hqg8rYnBCintyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a8b380-addb-46b8-0498-08d8f3ceeffc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:55:40.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ng5hyIrhQdJu+hMLZe+cmu6w1Hqrfuu4NnXaZnnCcWkUcNmrsKQg5CkVeXOYHka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 26, 2021 at 07:33:46PM +0800, Wan Jiabing wrote:
> struct iscsi_iser_task has been declared at 201st line.
> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
