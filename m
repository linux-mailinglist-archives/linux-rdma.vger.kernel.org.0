Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B09351E3F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhDAShB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:37:01 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:43073
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236466AbhDAS11 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFwoYuHdRril2SKnB6lPZkq5/KJf6EY7AfbJK7Eo2xx9487jjgu/bGn0XZP49yVgUkdQ3x4O8rReyYPoCZzIUkw6sJPnk042iQ4FQILaeWSTtAyrxkym3Qfyo/rwTAulw9P/Yn8D/trxsXKaSvZY+c4e1WHznIq52kXYw2dI52QNVI0KoSg6DCcRdp0bn2AQF6aI+Qxin3+7UgQc9MVZZH/yqr57nPLt+AnpeOTyiBjw/S58WTMiAmrBXcAKhVx21mMhZtEZmMCioKKJPPWbBL3PqxNv5hw2X0/hFbK3z44zfof1YyFhZFdgL/+zV4YpPZFFPFFFP6dLg127axzfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaxNRRgjF6XxYIgD8NVDgGi+mmM9r0clr3CKa+LE+h0=;
 b=lxAer1rkXS7iQ5unKe5R4/+iMnT6PehDG9DSloq0JKUK5LNmbR9Avar5TsxGzEgcOt8/KJ5tc1+YRzKIfjWNGPf8YJeEM+fFlVlpmWoUnig8xF9xNjdeDxxVpTFGyCzAiz81IpHB1paQHMPiwN7I53eoCHGpwK8hqyJUIn7VdptnM/au+Hgtum1FTt+3CeCxQou9c6QCLqoNTSMhoo/1IUyJTWaqoUtQpE5KYeOUwiH1sRHvQb0kQVjJ8qx7jf3xh1MgQLWqM/x63UcHfuq+Pdp2vXMvQ1+VaOyIZkgwXKJ6DdnhN8pJhLaOQsaefuh4Yc8/u5nORULleNzyuI3hDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaxNRRgjF6XxYIgD8NVDgGi+mmM9r0clr3CKa+LE+h0=;
 b=c4SKD/+64r9wDZ0/+0KDa4if/SnPeXUa6pTT+kmSgiFIi5CXhu5sXjRMq1JrpB91j8eBhAwHGy0BvOgqTJrfDmiHaRz1Ky5KWvDlFR++Wxk447+7OnutH6zMtbuVRVJw5OQtMe4FlkKWTJivTafsx8ZWGHT1kJ9si3k+waZPGv2tIzL2ufSRjmq/WUcqURLqjWABgr0wRU/PQGM7ltxVKU2xZ7Srpj+ASnCxqWEqUtDmW6hXkbhR1J/b1p/xzRZPYwpSosS7ijUs6WesHkOULRgfQTxOofDzsLvEjpgReEjbdJp2PfnhDsemxFUx1X790OG5DBt9+IdaqMzenPhZGg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 18:27:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:27:26 +0000
Date:   Thu, 1 Apr 2021 15:27:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/2] RDMA/hns: Support to select congestion
 control algorithm
Message-ID: <20210401182724.GA1636417@nvidia.com>
References: <1616679236-7795-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616679236-7795-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:208:23e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 18:27:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS22O-006rj7-QI; Thu, 01 Apr 2021 15:27:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840e011d-c82d-4fd5-b565-08d8f53bccc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268C1F6C854410CA81F6B9FC27B9@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bai0nk2Dl2JzZ+qpQjQmu95rEIQAfYVO4qBmRCx9ddzpSOECuY0SW9aaQjVAK4vyHSuAKLIQqzuWzQyP/eZvzVdstpDUbENzQSYXVdHnLMAA1m8gxWjmC4oXPzAUBT5OBmU09f/Cy8QCPvrqvko1A+/sJWQ0DyZYkKMBUzMEPMmQ5tRPNJI8yo9uOtSYgQiBPRopBl5ftICYSNgxqPgkZ/Y6qNNELL7+K7F4L5uFUPTETvUA941LIxoLTtikWsX4ok9GhMUUPIFb8/pbz2+1sO4j696HJtd34y/e67IKKFXRVJWSL69X2RPBZIqshuFkjkS3Rc/NfxkBpDdwLb6UDqilfxChC2mA5rUaJq+DqkKLWIOvekQM0lD01QEU1Zkhjw8tCJM7rCFnFdPGFSAdPkQBBPWs7NuXT3hkRm+duVpoGzkv3VUl+f35+xu9zeZ+oYn6nHi/6Xom5p5wyZ9j30cVV7bcN3EZ9SXCKWRvzq3yTNVYuKWgawb3GU6RhhqMsDuLd13z+x9ME1mqJmZLPC3TMMBRUByr72elAILQzWkclqFzFZ8hwmlWrn0YmeNXaEv0k3iAfdTW0oc3blo8yg2RSc6w8SlOJ7GomQb52/GF2642UrBlnV35bZgr+yjTXHgNSiJ60iAaOa+KoBnuMuFtfyUKhwtrKjnNRFs3edc0//oxZySqHUKeRiaDE5RAUbUMyR+T5gDgvY/+Y4paM3XoVHUbh/r6jYGNYn94c2B55rml1S4498VrhKw/qjl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(26005)(186003)(33656002)(316002)(86362001)(8676002)(6916009)(4326008)(9786002)(1076003)(66946007)(2616005)(66476007)(5660300002)(66556008)(38100700001)(4744005)(2906002)(9746002)(966005)(8936002)(478600001)(36756003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xydis/hoYKltA2K/oModXHr54Vt7vwwOkKuUQVgRBvUuILZ7LGfawJ67LrSh?=
 =?us-ascii?Q?3zFwtzvrzvmEsBygMkD1j0Weub465kwPFfsPJ0Fev4d26TV4g9jKUtokM8NQ?=
 =?us-ascii?Q?/K+V1sxe34Dg4Y1libRejZ0Uc6wDgdFx5vymekF9mjm5PM5qw87I0S3c5/S1?=
 =?us-ascii?Q?gmmJf74cIdlDOkVOwUt72qYkBDYtrzh/nUAxtFUy05868/WzZLta6xRKzYU5?=
 =?us-ascii?Q?teNrEKOs5Tu/MHDnghIA+5FneVfvdSsFiw3gQ7DOhM1+g2oVA9qZNd6I0H8f?=
 =?us-ascii?Q?EwgqbpAbX6rX00pMiWuA/Ka5WaYChi7mq1qTzciIj7qbHgmRGLDmXF4hoGta?=
 =?us-ascii?Q?NdiiVkiWGs1THZGEPprE7AWRlYb5ftTjkr6CXv0AHgTAnURAPdm2hZZDrYkm?=
 =?us-ascii?Q?4ZO+4ryHL+e57gdbEh35EaOQIcO2ZngI/CHdLj8teQeOt9yNYCDSCydK++iD?=
 =?us-ascii?Q?Tb0wkLkWkF7/zM0nSkPlfsuV7C/1gam4ETR0YOG6Zgi3jxrpjWyt2zWzQLzF?=
 =?us-ascii?Q?VigVrvN6vzUomsleuBzmj33zYV8uBlMmnjcgTKX8E9HFrhlLSp7/682qo708?=
 =?us-ascii?Q?VCI+8HcF8bXUEVKubOeweRFn7EyXDbxfVmlVS6q2UFgrSQoOR42PCKlI8fZz?=
 =?us-ascii?Q?xxSXvs3iRG9VX8nZaPLeBX9gBQ1KrQwiyPwuGigXHCthvTw7KyWxzBj8brSR?=
 =?us-ascii?Q?13ftycKH4tn6+iy4aGMZ7qpS6F1BrLo/GS5rRa+A6myQDNxckf6+Kb5Q8BOc?=
 =?us-ascii?Q?6YEGxdey1gXL8AwzZEkNkL49CYHrOXCsuF23FzQ0+XHeol8A8HE5lRx19Yvm?=
 =?us-ascii?Q?Mu7R/vt+VcKCtUAydJwd4/zG2h0jpGvSPb5jW621wp0d6g7woeqTaKgQvKUr?=
 =?us-ascii?Q?c+3QQWZBOi2+KdD09K66+64fpj07AS1qkTHhgklxP1PvapDsVlMsVqBruIhD?=
 =?us-ascii?Q?E8663BbArMwq+fiBHW30f9Gws6YoLvMk7+8G+5Me+IrAx/eAX2Q8vxq0ZdFz?=
 =?us-ascii?Q?Abiy5Bgq54FE6nTsKiT+UpPUwVihFBBkQ7syq+NFCIK+C+7lCn+j5Ai/ozAd?=
 =?us-ascii?Q?pYKGQKmxayhMi/kKvOjnb1spmoZdZ9s1P5v47Sb277+OJsFRGHi0/E36ilEb?=
 =?us-ascii?Q?XyJTz15m4Jp0ZSFloDPbsRbg/Sc6xGqtZxnEWipmQuKJty16e8kUS3XGp6MW?=
 =?us-ascii?Q?dz8n55e547/PaIfMA7Vepsyw2YHA9u1NBwcbOUOwKAgd+v3kAyKHXF0kaUQw?=
 =?us-ascii?Q?+N9aiYL+BkRVwi5DO1caYOGdiP2SPX5mvw54s0Hwey7VdljLIgxNMlE6y3+P?=
 =?us-ascii?Q?fTx+h0TlcE9si5KpqEe3jrxJJT2SiOgn8tACamcfi/dqNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e011d-c82d-4fd5-b565-08d8f53bccc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:27:26.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35irpXCEm53OhBW9LjUMMPOXq2Uiq2lZD1cJk5VEf0aegUpMCN4lKfTjTMtBBbge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 09:33:54PM +0800, Weihang Li wrote:
> The configuration of congestion control algorithm is recorded in the
> firmware, the driver queries it and then sets it to the hardware.
> 
> Changes since v1:
> - Use union to parse information got from firmware instead of force
>   casting.
> - https://patchwork.kernel.org/project/linux-rdma/cover/1615542507-40018-1-git-send-email-liweihang@huawei.com/
> 
> Wei Xu (1):
>   RDMA/hns: Support query information of functions from FW
> 
> Yangyang Li (1):
>   RDMA/hns: Support congestion control type selection according to the
>     FW

Applied to for-next, thanks

Jason
