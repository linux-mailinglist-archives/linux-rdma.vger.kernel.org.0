Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374EB38B369
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhETPnV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:43:21 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:54625
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232484AbhETPnU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:43:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQV/I90ZrzyVL2TfbuFBQeARXPGB7TFdAdJH/yqv52Zq4pIbJanWCbfd5W4vo1kttuLysg4UkJkCUGH0yvWGWGjs1Jv4tNtE6/kfPabs+kiZ/WhZxpHtiXmmSXx43xe/NIlyAwcPFlBOpyN8nUaWv7EDO1HUg0mAwfhuzQJ8YIDKoU0p6a6tiTOiQMuvZ8ezK8GlAIwzQbG2R1LrIQ+lNL5SJ++MmaMYB0WMe8gOHkLf6S9e8s2sYTIHM97K1o/lUIK1J9VHdRR9NjvWecDTDc8sN5yYOjHXD2ZiEQZcNTJMW4c1YdiS8QmfYZS7N/H3SKO+SXO3zy9MxTBfqVEo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y+S9pOz0V9qM1K7YuzK6x04O4k6y7NlqgxzH89IKl0=;
 b=EUz2+rq9N9yWXPyvkuqzW4M5T6tDyFIC9I/S3ib8w1GfHCRBmUUDTKL+Qb4v0z4kWxcFXBSpTzs7uLbZFL3YxwidArVyYtAchdSRAYc2JQukp0cUclDw1Dh3UmZFf/AflXTXRjd+znGrq1cOPPISh1HZ5jchfGse5BPy/bZZ0x0fB46XI5aRlYYXh7D/lsi44Ng6seavb8kOYD7yy52w42SOr60SdBfdJeCyJ+9Yh34x7BgJpZ0SssSQl8sX2waHgskN+OSWsLltSxu3WSuDrS/WMwdr32x2uHrHfjO8J+Z3a1GIfSdlpTx7yMz9V5zPKPZNM6IduoKcgXcYNPaRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y+S9pOz0V9qM1K7YuzK6x04O4k6y7NlqgxzH89IKl0=;
 b=VIQNE3XPU7tH3wmOpxer58Sd2qQAnzIoB5DtDkfTwuElQqAcxqGGB9hgrAXUhjcquHS3et1HueqLbJjW3cNQCjn3Qe9+GJqgav2wOCQNQa77wzF8Qnoz+YJjIxduCgNs3ISpTs0e9ElGlJ4sBGMlyz5asyIwSzcgQ6zUSyma5DvsgSFKiEH0q8exHy8secIYaXslRSlTHSBcDPn1WjgEpWCXLA/hpAF5F4onp1tXSyjtR9kISJKtYWPPQEE+/4RFf4mi7cPWNwZXJFBbhgejoxrVkWsMcSl1pdH2c8LtJZlhO4a/1jUqA7QO1m20lI+FVqgvxSki2NQ2y1XWNwhAeQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 15:41:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:41:58 +0000
Date:   Thu, 20 May 2021 12:41:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/3] RDMA/hns: Cleanups on CMDQ
Message-ID: <20210520154156.GB2749689@nvidia.com>
References: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 15:41:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljko8-00BXL1-Jr; Thu, 20 May 2021 12:41:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f32289a-71a1-47e8-5f31-08d91ba5cd47
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490FD67F24A0AC794D455B8C22A9@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT4aI6pHJvXgWzzZ7ANnr3zmy8h7UU3UOk2Jxo1AIk8LK0xItOYIQH2enWcdniaXUw/ax4yuVodKtfHrQcm0DgCaIe9ezoozEdH2s1ZD4r25/6CVoorlvDp4pSSU1MWvAOWeMBmRvJ95DPN9mLpKHcSeT9sc6PAxeLFNTm00V1TfW58L5h71oWmw4oKQfeqOqggnZZIWJeXUI2NP+Bz6DhdsiVC17Idk5Gx/b/Pdw0tTlNP/MGlFeljQmrU4ccm9LgOa8ZIvS8MQHxiR5T+cOn0O0BXjNOTB4crPWDrf3zb8P17ndVIyfFURUzkCaMsc5Xxx4FwG1OZnPvsU/f7mE/h2gM2VoVGc8sTDrbVowqKa2VU/iRivw/USWrxc5kED2uoJUMnqoBVX7nYOPz3i9NPX0PIeTpZA/W9jozX3RZgcvwNp2FrWh+M3o+J9yJ8dMbZHaJRY9r1iIgixeRYsSKsJn6c5Dy+A5UY1N2kJ1PuOW1OmixcbZBuI1WQJ9jkbTwDeCGmzk3VKDv9T+m2jfLwqk/gLi5CUtJ7WPkUW1vID4PmTdUIP7fkBSgBKQ4kXiCjWSNezvrF6p0MN7oGIB/Z0fMUR+IaLjNk7/ZhT+TlD7JUiSjko9ONlxuQlHE6DDQ92c4EmbxKcOSn5kHptrkAhql88MglvmTcMiFxOssgIcwcsdTzQRBDhyc+2FFGb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(5660300002)(2906002)(4744005)(6916009)(966005)(86362001)(36756003)(33656002)(26005)(316002)(8936002)(1076003)(9786002)(9746002)(426003)(4326008)(186003)(66476007)(2616005)(66946007)(66556008)(8676002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lh//g1FYm0N4hSyC6cO4E4aPlgfVimU//N/2g144Yettmh14c7jKE2kBvv9I?=
 =?us-ascii?Q?E97eUNC5TP1UTXGhvzLRfoRJgzsW1UhrA6Gij+xJXgxXXDJ5PLbwoIwN9UKp?=
 =?us-ascii?Q?FZnR38MDPrhQ7OJTLDejL4pfWpb0Gq2GsxfhlcA/QsfS+IgDkbOXd+xsuZSV?=
 =?us-ascii?Q?K8a/otqJmXYuK3Q9762yZ20lp3uyKMndsaYqoZ0slJYryaxZ8pAtp5MVAxy+?=
 =?us-ascii?Q?cNOmHeTDIQqpjSxmJLkiRqw/2stz5pkr+zDo1DPCWnAQ5WJPJAeIlimCyg1z?=
 =?us-ascii?Q?r76nQiPNWx/cnoqQWzIddM0zI8Nt23nQJaMDZ0S9odYKKzmQBVrv6wFBWhzR?=
 =?us-ascii?Q?eNXXNbblgx7cujqiS2MEcmahDofn1OCy7WY3EcIEp2CQu1yGqjuIy4yjysbf?=
 =?us-ascii?Q?rA3Ou8GLJ/eLMsam8WB9J9WiJk5laPF801deVuHT2IjS5DYwOzgjVh7dT96c?=
 =?us-ascii?Q?kbLO4wpXxFnccPfY7ETsEzR0M8w7IoIJgu/sfRCEpjepq4EEJLkf0Pe8s0Me?=
 =?us-ascii?Q?/KaSPxxvCXW07jItA8NJx74qB3epd+JCUbz8HSAWo4AeZC6tjccYWeYc6HLL?=
 =?us-ascii?Q?LugUXRGLa+Ll3Xho2f0hz8H4DRd9i3oGAwRPTFXwigDzS+955gDlGglkCKI0?=
 =?us-ascii?Q?enlCxTURxsWJD22bpwRlLJp8v2/OR8RloVSMtH4ZP2zFI0UE9BeBuuc2zqjV?=
 =?us-ascii?Q?Hn50DigoZYWGBMOn1WNJ1/r2wSB/+eKF5ZT+xvKG+XeAycwx6SjXoT1VkPRe?=
 =?us-ascii?Q?Jlhr6X8oZ6va9ibLwVh1SsPtVCrkZMzP5XSOoi1rdb2MyBCrbF9v+wUxV+1T?=
 =?us-ascii?Q?ucmGSoq25B01G3ydMjDzMwgn7mUCQamy5+CpwuPuv9YIBNsS81QDtumkJ+oZ?=
 =?us-ascii?Q?CllbB2D9cny8EdI10ArQ0B0wAx5zTeYpba9y8B4tsncJMQQpdA+3kJa+uKue?=
 =?us-ascii?Q?FSnK4+RUmCsZp0JVddIsG++faYRi8ZKswnjNo1ALoOAfihTYQo7TAzUbSjSD?=
 =?us-ascii?Q?DLw71JX3KSRdy76IX66divuW+KByJ+uz2u9R0Vh5ptnUZTt5Sq4O8391jdm2?=
 =?us-ascii?Q?Az//mBjhpPUoALKcf1p88x70x/sJn85ctQRpFlPlu5SGtSjzMOHbHd3/05Bf?=
 =?us-ascii?Q?W/Kbxo2DlAGx4uaN6bF1OTP5tnDJ9D6tMjLpMqwRvYQFdTsTR4P/HqQEfmo6?=
 =?us-ascii?Q?sRePYRxHcTW0J6L+ZP7ayZ9aP5fNjyJbrpqAD0z7dTz8YQrtgtr/dm33wsJL?=
 =?us-ascii?Q?Ln+Dk6LJz3Cit1JLXMMuU+gJlRWje2jnmdi5NGOuPtMrI41oEiJoSyu+Qgct?=
 =?us-ascii?Q?a2fRJN9mdzXfg6umguhSPRJc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f32289a-71a1-47e8-5f31-08d91ba5cd47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:41:57.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bu7w9MrYklKhkccE/29TusuXjbdPL1BIeJ4DwgFBqCsetgIBd1kulFr8HrM5Hbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 11:54:33AM +0800, Weihang Li wrote:
> This series first rename the CMDQ pointers to make it better
> understandable, then remove some dead code.
> 
> Changes since v1:
> * Remove the print in hns_roce_alloc_cmq_desc() in #2 because the caller
>   already has a print.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620904578-29829-1-git-send-email-liweihang@huawei.com/
> 
> Lang Cheng (3):
>   RDMA/hns: Rename CMDQ head/tail pointer to PI/CI
>   RDMA/hns: Remove Receive Queue of CMDQ
>   RDMA/hns: Remove unused CMDQ member

Applied to for-next, thanks

Jason
