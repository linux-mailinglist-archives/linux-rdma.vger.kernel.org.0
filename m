Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F297E358D51
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhDHTNv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:13:51 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:42561
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231451AbhDHTNt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJxjvPloDC/NdR/eTmzqjWmR3AiLU616WzoOBwFRBRasfL4ofqKvUhQeJ4nO860L6DmYTCfXwRSEofNg6YtR8442EMtO7cfZStXZZo6yPEfYTUuDMjYJj9FcM3lyxgMZe8d4gnsx0JdeTX3cIP7JDmh7nO9nZpfZElH7AM7ASCVEcFU7x2omajsHqtXYi7wXnyQszEVjCb12rAyUCJo4BflF7lV1eDwY6Tuoabus1Y01O4Z8cojZJzMrMRr802XTDnsRdYjxWgmLbLYeoZ4aznlRRUwkNrQ9EjLESIQSSJIvsFJBp08Dz1f2OVz8sApY5oW09Kd8ELZ0dJwZdCsCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEHVbTAlqvkNvti05TC8xI/adQqcWOI0TlzXvjJsq9Y=;
 b=biMb4DhGZeK1RRMIPxxRjG4vNmXmCCY4+Y3UDk31WCzk7VOADXC3SISpWfjQ6dVSEh2T6oLY2JYy/Nfofuthr/859mJLIUahvianPftQ8YMMhQ99AYn7xaha7h1rTDEaBLuGGtAFB9pmUSwPglnhj25KoCyBJQ0zV+X1EqGYTTrLDXOry/S0tfvae2bB0YT0y3N315eC6nnWuwbCn6XHU4gqwASUmpn3u7SquW+mTKlz86dCP2O9xHsJIh5vCNjyUx51mYM02uc6w0PdXb7OReQLi3nzCet41sxEU4p/q6N/k7tmS0DYcgXcjY1T2BlfZzo/8BrWCQ+f+N+sLq2G7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEHVbTAlqvkNvti05TC8xI/adQqcWOI0TlzXvjJsq9Y=;
 b=sXy44sjV9Jv+M4SX2cQ1pSeEdChYTJB+a18W5ZmnVZDn2z3vrN95J1mtBcd9weU/hZu96wbat2jtbT/hNgHtKYIAkW02F1GTOxw3EEO5AC+Q0hD8RWXMpSTZfTuoEu+0z4cyMgzxgDx/0X9FpuwFKfWU0wLF33QnTI1ZF58qoOXY51WYGYV1+QTfvpIN9SxTlA/ZcARLKaxuV8+MuDmFGwniExoItGeQENVmy/AqQJ9YXQekKZ0rQi+xW5wbTw5LPm7Or6fmaZM9WLNgdl5tJGyAe3o9iJeBDJMKn6gj7JoFIuMaTwNlmzZUWwu0yMObQDLriECnyFegnlkHAWIcBw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 19:13:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:13:36 +0000
Date:   Thu, 8 Apr 2021 16:13:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yixing Liu <liuyixing1@huawei.com>
Subject: Re: [PATCH for-next 8/9] RDMA/hns: Simplify the function config_eqc()
Message-ID: <20210408191334.GC692402@nvidia.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
 <1617354454-47840-9-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617354454-47840-9-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0062.prod.exchangelabs.com
 (2603:10b6:208:25::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 19:13:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUa5u-002uBN-Sq; Thu, 08 Apr 2021 16:13:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b39aeb-fdf2-4c76-788a-08d8fac268fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939A82818D727751D830E99C2749@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaoP8WiNl98+0lYatBfAc/TAUi/82OAeDBeN/jZnsNPMzCSf9WVINgrteh0yRNbnbtaLgEbYe1WjOnHa+wwm/pfLAChvNc6N+sVHzYEwdVhBemrng2FadOktppbZfOgbC6QRf06Q7ca7adKlvo8+IdwWlXbqAKAvfCI/WDNiYg5/qMJU3Fj812TUfDLl67z6c4GxottcmwiI6AcQdGA8UjsuekDINARxm5OsrgDd3pshDbdbX8uDhh9w+q4WK5F4Y99UjJYP3cT6kNqBupE3f3FDQQrV2RZTpAUJvznBiNXndO0WTF4NcwJk/avdaxKpUFx7kUa0Iy257cpNCTLxDpgnDhZpe5qEGngbpzuVc4OLQgBXBVmFkeMQPWhlzjm8kk+QrzcBBH0zYsliD6YWAFAUcFW5CJSTO5knwWVGyB4eNj/iQIz++18HqHv+kM1X/vkEiRliAkBxe7IG67NT8sPK5f75eLG2h5yf3UQTEIdPF5xATtH+oR3MMparOFrpLrOLGiEVUU/em4UTi6vpVdltno+rVAtCjOVSTf+UOMpWpRfejLSWgBDAyu6U3hInlj1l5UgW8A6DUYXRdqnRdcrn2WqCrjf5Mz4gH2DDxksPXdjxT+bLdfZQM51QtJ91qauTiQogmbygxYTHnuvb4IoDcKPLd144iCjQE0pC6kL0rVwprAvNIXvg5RMaNQRb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(316002)(38100700001)(478600001)(66476007)(5660300002)(86362001)(36756003)(66556008)(2616005)(426003)(186003)(4326008)(8676002)(1076003)(26005)(33656002)(8936002)(2906002)(4744005)(9786002)(9746002)(66946007)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GfLdK7oODt9qp0tfwYdVsBYjURWU2bBn4iApiS1HQ5XGVdDSIdrHOo6DYDjV?=
 =?us-ascii?Q?fxrqsmD8sdtL4ypwN+lRXq7U8qOEhO2ArJvXVss3olcdmIqOYH/WfkkhAbtg?=
 =?us-ascii?Q?efIGILYxKycHFfGfSBhFcCv4MKcJ6q8aPTY5QW+YMhjJECi+9UONMYi58X7g?=
 =?us-ascii?Q?d6LGDtmffSUMw59yl5uMnDRhE6E/lzE2QiBnj4PII1GRJV0/zTe17Dwuo42f?=
 =?us-ascii?Q?S+qK81vYhRcNBBy0ZqMFrYRPDeeSukpUitAC0N9o07oJL4HbA+RSwgOlTswO?=
 =?us-ascii?Q?JyrsrNe6gxBr7D05UcN8IDXmBWovMTC1cbh+4XPKlTR4kKr7Eb0TCyrPcBiZ?=
 =?us-ascii?Q?jpPnlkOaW9B/GOE3eTMn4L4p7LkvT0uZwVRvp8Ksxo7IpfV2VM0OZnyDk8R1?=
 =?us-ascii?Q?tZsrFYn5ulBKhcz1vns12HfXTvMExu0/MjD7murKwF04h2ulejQW+8fM+JHO?=
 =?us-ascii?Q?qqwgfzkHEiWdXDJ2Q/hvpgjvGKJ07Fl8bZMHHDuwz0hIyVytCjp6ZY8Wfzpn?=
 =?us-ascii?Q?8Io0neSNLm0ijItVoO6VU4niFQEPziZhXDGxvxeSPm3/5uVtj0SIrjBgBziu?=
 =?us-ascii?Q?4TxNPvQ5HWVnia+eGVXh688i3VIEAn2V4VrgBtqrYyQdlNx7M+lnhxqPWx5B?=
 =?us-ascii?Q?am5MO353ESASuPRXPfn4ffSBFpfMPdJ94CSNzqOuV7Y5PMcIhvIMSsQj4QJD?=
 =?us-ascii?Q?PHP5vGblJkZLc2rktEpJMyPJfSTv2PegzTLUBGrFiUJkmSEmLSihM2McSPNZ?=
 =?us-ascii?Q?GYUFeggkxlc1qBcnuCW78IvVdCpuH0pCjqZC6Cbe2tZJu9S9Tw0cStlAzxHk?=
 =?us-ascii?Q?Oy9aUJddl1CLU0YLu1Lv/CG1Tn8bjsUkpA6nKQlIgKDjz3LXjZA6Mj2G2/UB?=
 =?us-ascii?Q?ZEj2a0m5P4KfIcYkJOsGmvOOYa1CcjeRghbzN4INoGkA7TjEB6O0yBbp9JeI?=
 =?us-ascii?Q?qx28+lYcnRgh1raPaKl40LVenZA8Z6e2hKcq3qYopGZWPQ6cNGZqx0Vn7sPn?=
 =?us-ascii?Q?i/IsNfQb80H8qsLbr0TdVDLmdG4P0hioYOxePV9lZBbSohnbPn53/fIlZSlq?=
 =?us-ascii?Q?hTtOgKepZg1gJuB6cD/I4+RRQEzBe1K/ELHR1sCsad6Sa0oRd4eWAGFS+DZo?=
 =?us-ascii?Q?Br5SZA0zHcMzM1BgluxF0BusaUWLRAXEb215/Tzfr2nDXMayxSR2sPq0V0rF?=
 =?us-ascii?Q?9wyR6zE30Zvn6Fq7JdPs7KWobIXXisdQF6XMIRxV0mnJD1OZsrpgSQWaAZML?=
 =?us-ascii?Q?fVQ454+jd0KfVB3ayPl0oI8u4SFJnnFLkdAy+m0LiyMRZ61aznNBYjXMPweU?=
 =?us-ascii?Q?Tnf/scmKcv6PW+NApDntisMN+u7IFXzLHsnLiNzQEjpfQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b39aeb-fdf2-4c76-788a-08d8fac268fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:13:36.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMhu/UvRkCO6XIyvCmIlVMDiEvKyFMT411nZ4dSzWh54vDCp4p9E6os2t8REASs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 05:07:33PM +0800, Weihang Li wrote:
> -	roce_set_field(eqc->byte_40, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
> -		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eqe_ba[1] >> 12);
> -
> -	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
> -		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eqe_ba[1] >> 44);
> -
> -	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_EQE_SIZE_M,
> -		       HNS_ROCE_EQC_EQE_SIZE_S,
> -		       eq->eqe_size == HNS_ROCE_V3_EQE_SIZE ? 1 : 0);
> +	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
> +	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
> +	hr_reg_write(eqc, EQC_OVER_IGNORE, eq->over_ignore);
> +	hr_reg_write(eqc, EQC_COALESCE, eq->coalesce);

This really is a lot better like this, isn't it?

Jason
