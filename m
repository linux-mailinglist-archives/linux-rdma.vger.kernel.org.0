Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF248350155
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhCaNfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 09:35:37 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:56609
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235701AbhCaNfU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 09:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si1wUz7w5Buuqdm+LhSJgCwQsdFCM6ZACJQ5cWThFHLS7n4dXEAuNz6qJ/4YBkZ4L+54F2BtTkzgSr3vMCMa2AGT79vd3er9Z/T7413NrOScjebDJerQ/1YEe7uczvHUw1V8ukJJZ2yoTjOmot60vvfTjrcPM+ih/qS5XTAyjN8o+wAn59q8YgnG0Wdwl+Mb8yqUNG+SK1YmyuTg0eWL4FFXZaPNdt1JUGRmXZkmpj3J9Y7i6P73rXS9QcTL2SiByc9PThBjBgputryih7dYU1byhssM4OFBidSILqom8hzjxJsqD1IczeafcS3MLj81AUfJbeS171yMJ92rx9W+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpM8qv6y97hqwatJ9cbW4ND9mKmNCCBQKxgiJ3ctpjo=;
 b=OHiv4Xn+w5b7JBPJgWVG9YOimltlkaXaRKAaF/snENsfcHurxa6ArG3PPlOhNNf8FFfggGzFmZIY74ljil25jMIWu2AYDtFRcOGWYm9powSSQ7c6cuUxAbDG3j4UP//q2FNGCzqN+0YbvdGvUUyQvov9WB+5nGWDrGy4F6RhPdNLLjIa40du7s8YJb9uF2CKQi6P1c6KidYA+9S95P8ulVJ39rf3l6AFzEgzvcT4xfvwbe30B7NLV2hXq5Yrkwi6tvey5fC+L4BRg6DRPTXH4SFG62V73Um4s2ewiSHrV+ydsrWGAVbCwgpsrWnA4ckg8acDcmKQYyDg5ngY5XnW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpM8qv6y97hqwatJ9cbW4ND9mKmNCCBQKxgiJ3ctpjo=;
 b=oSwW1hDgYOvn7ZT7IE5CcNSSxUhaXB/OencGMbxWrr/yQcg0kRyeZnnMX8g++Hls83IUwa0Or6YcSNPI3Hmx8+CawodccpmVe6Ts2lR+YFQ/PwX3ekNcpVRVNcgrBBNU627Nczu9DqLLSdF9N8aRp5otN+enMq0jeR9bSX5Xa3wxlY3GN+3IdNpGSrtrnp/NJbgBw+kLXVHFMhZFx5yUdEV2IrjL3m/vU+VAuE9+6lOlgFCNPpixY4wlWP15MfNW1JvptvDx3LQYyUmS0+/ODBK39CvQtvPuXodyDhLBAJ2bG/kIa8r3Ybj1WOKuk9EdZSO9xyOIRRS/FKObyd6lmg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 13:35:20 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:35:20 +0000
Date:   Wed, 31 Mar 2021 10:35:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331133518.GJ1463678@nvidia.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:23a::33) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:23a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 13:35:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRb0A-006LQ9-B8; Wed, 31 Mar 2021 10:35:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f49512-5e13-4960-3138-08d8f449d3e6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4083:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40830F1268DAB8F01B6A853DC27C9@BY5PR12MB4083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU+qJ8Ww4gulvP59PN7akntDLOU2+K2dCs3RixgKoA1O+8tDnB9mDnRXzQ1JOCe10fKDAyJkucczdYY27Ct1HRvkHIZVahWwKuFJXcgW0Wwn7TQoEarj3ANnC0MzKT9R3g5g2npZqtZ+NmB6bPzNle7/DKtZLGQBVbhrRODt6IW1y2oMO7+nnvKrW6Y0lFWjcQh/FDPs87PL2+Pj4r08/7D2JMnBc8zAUQQunkbxQ9dhRsAC6rtNsxQc22uU4kqan9bEjZEi1bK55Pfekbq0OM8NVDkYanUlmDIAcJ7ZpG41C0ZBVjhhIUus8dHMKVu6hQ4H9YgSmk0LRNwjvYmQ+PxEXSRxK2iqSykHxlpmfz/gwFeTlreQ11RG8Vp7huN/jTJrO8rsVI9R0bVOkKwZta1gRJPNpDuXI5oAWcIyiCYjNG0YgY6HN7zWBWSsB1PgndyK7MVbKkJIQ6Es4n0bhQtuWIbxTXFqfNC9iPnSlUFX1D7xnLQGLD0koUaYnEgFIO+UFTn3YXl4o5sR5mF8b1AAlKcFUewv4tzrE6t8Cmbwa0eh+Ux7BR7EDne2IIJqv8bCeKbKCg6ZM+ziDIXOD7xL50nGW61DnevrUhSn9ccurFQXz7CFTn5fErfMtwlK0bnmn3XpndxSsv2kebQRgng2qpdOUdTZMRj2kVdqHIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(38100700001)(1076003)(26005)(36756003)(478600001)(8676002)(9786002)(66556008)(9746002)(66476007)(186003)(4326008)(2906002)(66946007)(33656002)(6916009)(2616005)(316002)(426003)(4744005)(54906003)(5660300002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2oQyJopf5rENJf65fLEYy70MlBz7q6XOiYQK4kREBBQmIZUMam2Sgnzg814v?=
 =?us-ascii?Q?LRcrkRRTrMpdUO4aSlWMJpi8iWg5AoWjxjP1gTLeQDqY0s907sHFTMJ0iZQj?=
 =?us-ascii?Q?nR23MtWhYqaOOfKwzl5CliMh0HxwRRpKaRVZZ7G+Rf4acbMLeLCg/pVSLlEi?=
 =?us-ascii?Q?NitZAko7jJe+0sWugIyx5DEOwgrkyB8dXzG1DfXZIkS4R4MVqkw8TWwYr5sA?=
 =?us-ascii?Q?ZWmU5K8Plr3KMFTagca+c9ChStB90Gq0fYyGwpe/j6tfOGY4I7BrlI+iau34?=
 =?us-ascii?Q?Qzx+bTC7EcTnhaTKqiFYKW3uGjnQL2Ju+YVdwOxV5yjciYXwmIQlF/zSKcpV?=
 =?us-ascii?Q?PU3suzHl5zIbj0ZA8uofS0a6yJnNLlb1VJQfjujNjLgX2PadVo0GtKORQvl0?=
 =?us-ascii?Q?zIj5EasgzkADkwywpfGUCQ+k2gmPwGR4bhMD6CE/mRQfwHpf5Ea+rX6zF4EV?=
 =?us-ascii?Q?uh4IbZwhLX8Zc7TO2IsbuUOUjoniOLbrtOlXJ/0PXd2gh7UtRnX7OpwxE3Ij?=
 =?us-ascii?Q?FBu3bY6xhPkRcgLw9fS9g0sCPTuW/xz9Wt/s/94WI0GaWTqb9tBFno8JjI6M?=
 =?us-ascii?Q?yhw/m8/JGN9UZtdNL7r8Ydr2qR6EfF6EEMtIgKNG1VS8voP0ltVRWLdKziwP?=
 =?us-ascii?Q?R3zwk36WUeQjH9yG5i3jQLnwZ1otRrBegK4s2H44EYiDtogdIcoh/oXF41t3?=
 =?us-ascii?Q?MC6z2TZ27Gil/tDFb+U/waRyCpNKWPt6I5kR8nNSV0UqqTz4yA9ZBvUDjeok?=
 =?us-ascii?Q?ekDpoKoe2xQJtm5BehmKOPfjH1yRrw3OXqKoZURIPBX0nBq7jhY5NDDs4FoI?=
 =?us-ascii?Q?7vDVnj68FAjpnwpSakTC2y/vpkTAuMWj57wLwiwMNCACgypRiQx++ED+/F61?=
 =?us-ascii?Q?1T4xu478EPW/KVrfPbFaDkgU1pEmCNMEHU4cyCH3O9JiQb7e0qHVphYGTF7X?=
 =?us-ascii?Q?lXkxCwXfGWFbyRd2gHd1UVIcOW63PrJnjSfzKZyfw/aCU/r7k2XzaX83RcQh?=
 =?us-ascii?Q?VaoGOLniGZRqPB2cFkwrKqywWFLhB37TqSn7iNh9cZAfAw7Bl/seklfPIz1I?=
 =?us-ascii?Q?Z81rFAuAwrcobAkQul+Msk6vhhM7LCNoaSx+MydbMKDw2BEIp2aT4VnLyRBD?=
 =?us-ascii?Q?X+GWvDV+P0DTXZeiWho4Wg05h9+nmKEntjuVvOUqCcRrN2EQsmAP5jW7MowE?=
 =?us-ascii?Q?H15Vypm/FBpcqCAYhD8GT084K1vJPSndzhA9taW5ltY785QBJVsUVCvEplz6?=
 =?us-ascii?Q?q62exPuUHF6tXTu1LRh5XEEx0O8awm6+pOqCPekmEMPoHUlbEv7v/BNuNYIU?=
 =?us-ascii?Q?YBpBcNhMukmlQ96h5oAnjgrbVEOC17CfafDN93Tf3C8iNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f49512-5e13-4960-3138-08d8f449d3e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 13:35:19.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFHklueuLBNkz/bnaGfA8/VWER7yqWnxCt1tsZymOi3gg3c7upi6PLrEPGsasmKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 01:34:06PM +0000, Haakon Bugge wrote:

> > Actually I bet you could do this same thing entirely in userspace by
> > adjusting rdma_init_qp_attr() to copy the data that would be stored in
> > the cm_id.. ??
> 
> This will definitely not solve the issue for kernel ULP, e.g., RDS. 

Sure, that makes sense to have some rdmacm api in-kernel only

> Further, why do we have rdma_set_option() with option RDMA_OPTION_ID_ACK_TIMEOUT ?

It may have been a mistake to do it like that

Jason
