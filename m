Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9F3426ED
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSUbS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:31:18 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:53504
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230449AbhCSUas (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNNqp4vADRUbPzKvuw6WN6w4ujqdUsdEmsZu9hVmDWiOhZZrRd5nUXf2AfWuPurz9AtyclwHJy0V6KqLGEoP7NfZ2w78km0TqEELfAkq+Teul5cMnSjh/bVOU/MAkVaKGMWnwKnF9w8rvs0c0/fzyFxtu/DhdSfGCyJkTAvOFH8QZbr/wTmxmMZ/hOMWLLn+cvXuueSbzXDjcArjP5ng/K6v1rXt9szCRIKo6NWpUZigRYp9pS0EOgBp0XfKqHd9Q6Zv0AOmeKGDSYD8Jgoam7QiZbBmLf908Cv8smskQpDdOCeBk5yVs9yNuwFfEjcFWRM2D/mHLqUv7RNnkNXAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z/W4XibKcbqkDQmSsm6wUmrE1UmFyXdX0d352Hri84=;
 b=ahqB1ro63b2Qv/1WXKMuXnXiBWufVI0fXt3xQSY2+Kwc+VwaHiPrPuQhQZnDeil+APnPVK8EjUpJBa6meg/xqw9KLg8Elo7Qgj4TeIVajJ+OUmaeWuw+QBI2VKQoK6exYTsWqSYpSdAQQm5xdEtuIX1U77c0UuZd5m+u9J5qvMEvVznQ0wJ510yBt/2C6QVjIfxp4uLvI31cVzRqa4or5TNZPBY/7U6PsFFGPXsleyiotOm0/i93C3KBNBvGQ+DJaX+WRRWt1h1/oAjh2UNgC/BGRDRkiwtla62KIN0qHQ9CKDkHxt8ogXIwWQ3AFhLH+MoBSFNZp5Rx1qedKiHEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z/W4XibKcbqkDQmSsm6wUmrE1UmFyXdX0d352Hri84=;
 b=P4a4nKrYDkNpBkcAa0Tc3cyAU7aLnWH54w0UVSbxr/m6KsHdc1fMeUXSLSzBHuvlNpPzccZ075dCCBLF6JF5Gzj6ciYr/gmPbPFKQYh4k5wNURdQh1Vi/A50zmSYRVUvStYNT778CoKE5TYR6oGmFN86hJjsa9ofoZMjF3G584dHH4lJT+Bs+BedKGGL3XktUJvQUrl02RlvmeHMurDEu8/o7yq1g45r80igjDrDOt5fNl7GEW5ptn/k+V/A7gbo338UIUIUYivp3NhQLrE/3DoW7Drn8y+gvJuLYRuNpLQxS1tiZOUKtZmB0WJJWurC8tlaG4BzesgNeJtadhP10g==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:30:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:30:44 +0000
Date:   Fri, 19 Mar 2021 17:30:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319203043.GD2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <ed0d861c-4352-8568-b3c0-31a0f1eac228@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0d861c-4352-8568-b3c0-31a0f1eac228@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 20:30:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNLlb-00HRTU-BB; Fri, 19 Mar 2021 17:30:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447ade72-6485-4796-0676-08d8eb15df26
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31147272CACA37FE99AEBB02C2689@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t05BYSIPjbNfqs0ZWAeBI/1yrIPbMe1c6Dr4XjvfzLn4t3gMOm4oHTD3AdU2IiS3TH0H/eZZp4r8hMdmdjADgkL6Rq6+Qk7YbeyMZig0RHzd6gzI+G2M22s/gbaoffNe3l7GhzrcaJ1EpTGOAcDfBD/n/OOuEWYkmIcsuQ1uHZQCYpDGyD1WDTjw2iq7WHvNlqnWxCzK3t3F1zuzTghB5PomDVwdh2AB19zF8Lk/AsVv8RErwihb29KCgxLlzfso+aigVZpLtwl18yBTYR+tYCiwEsHldmdy1n/CwR8+pm641TDDUT6x+ZvEQebYwMNFMtVTXpTD+NMNecRD1eLVrDCzsHZEj1PP2BwEgr5+sktGs9WWqq9XwP5nxVIVC5fPbklrl9ha/R+I+sYmKr7DptGEQBiT1bdSpNdWIKZdol3szlrZHv9TLuAiwBoCMqGnPheie9purmSKxbXrcoDPSIL88+/FKTFB724LmmcqMUA2qwrGuIuZLr6XKX9HUB7PRCO0qCaE+lXolhIfi5ccTBj7ZVMN6eAQMmJmJXFbKdSHONSWJfqPkEAZ/8USZx87e7+dqmm5OXYkQw9JXalEfTX/jFvMSgvkAHP9zN+8PXYgTrSXgbv1Bu4zgiOlKvbsfuHBRbctKVw+qbmKowlX465HiFszV5Wh+mx29Ma6FDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(33656002)(8936002)(6916009)(86362001)(426003)(1076003)(558084003)(316002)(2616005)(36756003)(8676002)(186003)(2906002)(54906003)(5660300002)(26005)(478600001)(9786002)(9746002)(66946007)(4326008)(66556008)(66476007)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yPavwmyGgv40D9RHQnx3y9ATnW5Dw5fPWIu1+uqYayvQWt+nVffN1aeX6rqy?=
 =?us-ascii?Q?AtzlegndNhhlWeLVkj5tM3DC+gJ6y+03SPG2VdyuCctv5BUwfZYjSa2HIPvn?=
 =?us-ascii?Q?RnkEqI9ARxCEi/jcpEZlallhX7JJbA7UWfiYId5Ks9zwrWiP2vBU5lQj++gA?=
 =?us-ascii?Q?iZwRMlgEnh9aN+ow7ZY9vDnnUOpxUeVfCi5xZjUtHO+Dm1M7Hrv+49e1nfX3?=
 =?us-ascii?Q?B5hO0yJAAErhOpDGqC/o8LcNeAjCjBvryEa0dGCwU5B51oeQNl4/O+OJbemD?=
 =?us-ascii?Q?DBcO180DJJbVQ3jxIDwNrOZV1lZXSJvqnXDaY1CtjvndIvJyAfDJ09VXbOpI?=
 =?us-ascii?Q?Lt3rPJ2Bvqr/yfQtlvDkhro6RH4eZiIOHrkE3aLQSVD//ACRmMJhRiSuLqJZ?=
 =?us-ascii?Q?bebrOdiFg8pszRh+2vliwU2rGKiTYqTM6ArulygGkiWWCjZHwO1ChUQTGktS?=
 =?us-ascii?Q?LQFKEoNUNx0EmD0uytVMi/N6196F6Xof3b1poelSuiTnYwiulmtDarLx8Dwe?=
 =?us-ascii?Q?Wnvcw845RyPHmocrB7vmEi/0ofQE1PBi4xwWrsKLailXsc4/skzzyTvxj6wd?=
 =?us-ascii?Q?Y6KicYiRQ2YBIcxnrdxNbTNSubkGgTz4XRlYsIXK0q+FkgFGCZWr01qBqMS0?=
 =?us-ascii?Q?4cxcEw2StkzXf9xe0oS5hhc0gMIMJNmAJ/2MkBbuSCr6TaV7euBgUJYDkHyC?=
 =?us-ascii?Q?5bSc/dBgnHsiWWhQGrudIRYhw6nw1jJQOgI82qDw3YXqrxiD12DCQTeIg+1O?=
 =?us-ascii?Q?qHXKcPUzruvHltWW0Cd6EKZd9T0HZCYMqH8LBNzXkw6kI9rGhBhJhM1porxw?=
 =?us-ascii?Q?ZoSH89LYK9+8zNPO4nmp/JrSu9VI6Bz5mPjdS5LoLbTgc69tWH+jcKlnAQ/P?=
 =?us-ascii?Q?vRlhhV849Pa4wMev1PP6XRQmXfs7CFjtApaYFo2pbLIVVVXwA5lpOilmps7p?=
 =?us-ascii?Q?YUzYyupMaqPi2HbuXk4rdjZUqrTV+YTe3jArPgl1uDZQ5KMhhyPD+fdm2cj2?=
 =?us-ascii?Q?IlcCl/nV+fD582nlpq9h13GE0/i5kDR7bf/LGW9K3JUmz7v6Dc7DogIvtxzJ?=
 =?us-ascii?Q?DpVoO/uBDp84y1mSFv+Oyr/ZRScZlBsfdixIhw5N+D3qMhvZFM5wSXszSZAD?=
 =?us-ascii?Q?RlR3HrYKZsy+fR5iVIVA9mpCtTAQkzHnM8sTXv2ZpnXzP8khFv+/hXkp/l8U?=
 =?us-ascii?Q?7i8kZ44DVYg/Xaz8Cw31/watMUbRETabSCGdF7FcrJbeJtqzjqKN/eftQDuo?=
 =?us-ascii?Q?YhhDhLJa3Vfi18NuRk1hNZa2ut/gCHTHVECXe+nG9MaCZ4z14Nc1q5b6qvBG?=
 =?us-ascii?Q?nuxrlcBky/Nx0/wI76WV8FHb//9HI47/7/CXBms+xYg0CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ade72-6485-4796-0676-08d8eb15df26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:30:44.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFaSnEsiA3bG86wkJfUPQOX8lGWa+qr1lKI3h5nYbNBOrCg+LrOqkhBmKcrJAeFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 04:18:56PM -0400, Dennis Dalessandro wrote:

> I was just providing some background/clarification. Bottom line this has
> nothing to do with hfi1 or OPA or PSM2.

Well, I hope your two companies can agree on naming if Cornelis
someday needs a PSM3 for it's HW.

Jason
