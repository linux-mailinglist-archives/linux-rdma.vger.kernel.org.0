Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887D5351F66
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDATQB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:16:01 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:40865
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234791AbhDATOh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 15:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G31NRhJUhH+DA6nM98Dl3M3Lf1nyfG3nqi5rjjyGhrN08AB71/EsPKAu4hRA/+Exh8uVdd1AsEBu/iVnE9tQk9CNqarBQOJzcx+Y3CBKWh6Kpx0I3suESnTpblZZNyUJcNYszfl9MypQqbgCbrJbrBmxmhM8AYY9uXa7X2xicgCDAGAo4ZujL/4/Dqo7xWPIB7CSW298+2OjIqxAB8P+haOXplWOAAwUGyroJgy6w50/qkfAdSOe/BrpJ1LsFsbS09JL8AVCIK9U/X+EeEgk/wQPaFhwtn5pHXv6Vq65P0dq7V8NY/Lpur+ckALwLbCMkKurI7xodzSz8WMmLeFUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpgaZU+nh2h0SWEfe8XC3PpkkkpZaR6QZy+7Cp9tHZw=;
 b=THeNEC6JeotigoM0OTwe9vuCq9nIUvORVoCulnyM0fh7mONgUJ1vbKXa4shIP94y4vOoU93TAasHqlRAgykAEHl/icy8JU9SNCwPFAI26AIw6Jwbqieb7X6qmXdlbW6LF6kGJ/ufCFGQ9IzUqFN7KIb3ZllkLbR9qIU/OYI0v75xDZwHPXa0bruOQJVa+DheJ2aOWqxvWoYbZVsd3/ZXcHDCd08q4t9ROHEXyRk4town9fkBZ2fCm/eIQ3X2ujIdeb9bib0yoF3HJgcBaX0fCvSHiIA+hx6yTJ//Ra3scUZfeUWhhAOsVmAtdByxOmKbYzKHq0k1B63ptyJ6c5iEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpgaZU+nh2h0SWEfe8XC3PpkkkpZaR6QZy+7Cp9tHZw=;
 b=iiPrf655b2UkIecPGJcvm6vH3HpuyOEPWJV1RR1fNAhnasXkp3BbiT34XL3kcuvNtmmXhs5dWcYxQdmKq5EJGyIXM1joBqIBosTQ3MWBt5kl9gFUl7yC3C/Oyw5BJzPhxefL/QuWf3MsiCSOzEJTHmAWK3+xs3vhXHlxQzfMKs3eXV1jYoJZQdcU7O5+lLJY4izjVqvBE5V3CG0FvEwn5ISOs2GlmYjKzd2auy3NapnAgIMQPAbtOBkkHZbtEDgqXH7cetQwwPNl6YlLxBgf33qviqOQ0W8npDU/4XxBNzIM/9/bC7ASfSzPY0teetzK2OBZtX745BB3WfcbI1Zp9Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 19:14:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:14:04 +0000
Date:   Thu, 1 Apr 2021 16:14:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/5] RDMA/hns: Refactor and reorganization
Message-ID: <20210401191402.GB1672136@nvidia.com>
References: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:208:257::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0052.namprd13.prod.outlook.com (2603:10b6:208:257::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Thu, 1 Apr 2021 19:14:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2lW-00710t-4H; Thu, 01 Apr 2021 16:14:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db6d0e10-06cb-4d0a-fac5-08d8f5425035
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938F61823CF22D3CBD82C4DC27B9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vjhkig11KqMdqfAAkISONbnHlUcprKsdlVfIkMuECofsYgzPk5Y0nSD8lgZm9we9kZQCXblLudEfsL/2Hcs45X+gKDy9crEPYTDecBton+krEZasZpIcIfUzkwZSJq/UzR9YUHssWogrewk59QzDbZPRbbaOUCCBAx7mXP0/z7pQOVw1wJg7Ms+uuXN/4tsHo4CreyChesRs3FlSMevNi016erarbImFpUOigYGG1eY4GPpQ63YG3MYfPizVNFCMr9KOivANCk5+SOb5VCMsbU1JCSGG+khvpgtTV2UvDmzi0ahHeL19QGYyCluywyJfeA1iRQgsV9A8aoK7/IrKLx+MbtBS6oK2dZk6RlWEHiMsXeYrEgCEtqyIzjKhq+1kIEzMJerh0EeFQdunElTw/RknFVMBHpP5D2SX2wJVJ6tDaoXOw5AxiOxalJ3t/SMojFseUM6HQ8hecguklKvPk3c1hQjbh3uTJA6gw4letD9+8nOuFL+xjZ9ud5kIIzNR3Smwu9MzgpjyMyQh0xbJLYtbFPDVnWvKxAXRA5cwoX88p39bbKkSSR8JL4CTY1r4kInS65N1HV5UkazXG8OmThETX6/mN4sc0xiVN0xfmEsHzLsJvV7q1EPpy9sVF6viNyksK8dqk/+um8DK6K9qmw1g3I/h0b7ezUyeSJlIhbUSRWkzuKTBRq9YlBjvX/KWNa9bVYtjuXpSK0HSBdME5JZCAcPc7iFQzdOx5iOOn9ocOtTopFPFJPUvTDrIp25K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(1076003)(86362001)(66556008)(38100700001)(9786002)(9746002)(66946007)(36756003)(966005)(66476007)(316002)(5660300002)(8936002)(6916009)(8676002)(426003)(83380400001)(4326008)(478600001)(2616005)(26005)(186003)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l1KvtcnNZjXGNeIQga/a6Rkl6dVFLXOszaco9mz+m+dXhfJ8L9PvG0GuApwu?=
 =?us-ascii?Q?jiA0u2o43Aon1URfWvGurF3okcemFcOmFeHFUG3Zn99Z4F6XdUSJJUot8sxI?=
 =?us-ascii?Q?xjqUxghSsckIzzl0LDfIva/hpltifJorAjAb5gB+BtGN0gW0D7VsYktQ/Vxr?=
 =?us-ascii?Q?UCfCETGEbygmp0M5NQlEEGe0IWwyUrGfPpgdYVrOpJMipG12mm59H2wuO0Id?=
 =?us-ascii?Q?kwSYNazbqXxcsnkVHi/M3XVXfJdGp9b6muWN5dHsitH5xAUYaPXixMrqSY9H?=
 =?us-ascii?Q?QzLXTsjt9pVDPaApcY7/e8AIy3p8NX7J1awPYgOGa/14OejT18wiHoYP/0dI?=
 =?us-ascii?Q?s7KthKUovBN4tZn2DyordbWUrMhuzl0qEwIxl5G1QM+Sr1HlxENyx4dpUPy+?=
 =?us-ascii?Q?iQLawh7DY+CuaXtnRvij+INal0BCaOYNmwJ8g32XJWeYCP2m+AVTiwXnzf7F?=
 =?us-ascii?Q?Ylmwkezix96E9JAbXbTZWjsXWhVO8W0LzolAw4flifsf+27QnKonoTnB57yi?=
 =?us-ascii?Q?av/NTt/UF5gi01CkclCvBwHvRErpYVl0AceB3qSss7vX4HIrbAd5HXqGwlja?=
 =?us-ascii?Q?OhMww9xz6GS3qQ+kEc60fOZjQN1CMmsvB6t4W3xnw0F7Ldr+8LUX+X+rgfaY?=
 =?us-ascii?Q?B2amCQHmEQHiz6qs25CMFMRD3Qckja/lZcbHQN9OuCUrB2GZq0sBSMJZ4gNR?=
 =?us-ascii?Q?DfEA0/AnsrysXu0PpqwO0gl9H77cTYLlRmoIiXWnwJS+BalmJvhL8K0aGSNv?=
 =?us-ascii?Q?xK76FxB8PQUbiJWGrWtxiHkmfp0HlVqleVIdmOi/qghB/X3HHDKXqYGrN5BI?=
 =?us-ascii?Q?1bVYaUrp3VZcPbNhCcJ1I7S54PUJbT+JHCHZLTj/J1xH07/KcXsNYrsK0Q0X?=
 =?us-ascii?Q?4LF9hzM+F5P4ga2/AWsme4+lD1UumvI/4Jj6BsNGDjSjvITRxx8Amv6QA7cz?=
 =?us-ascii?Q?neC1KGCgHPx1Abv7HVTbXxU8mEiG/yT1AXM1wLG+8OtM6LQzrCRO/4lwbegA?=
 =?us-ascii?Q?Mi066bAMCAezGstpRv3lfC+/oGIF9COuQZGjm4eF+5EZiXAG0kfNbiLwkRCl?=
 =?us-ascii?Q?UZ33TtE2Kks+sk1n1AuSqDu26zNnKGiTifjtbbvqwRAb90BrHP8AmuVI9VJN?=
 =?us-ascii?Q?BuuejT6ohiLMY1B1dAeDlhRG/9kFgjgasXAAZdVVG/IzilE29L+YZOFMrJgy?=
 =?us-ascii?Q?YFfco3BIkp+WUa7so+SjcBIQxy4aVvCYZsmA2HK/xZLi8bejgmn8bpl5wbrZ?=
 =?us-ascii?Q?IVkLJSvvuRcxzW+yUt2PBKEaQRG+XuigwjyDaZnTByRpnxSf274mxGaVy2Cw?=
 =?us-ascii?Q?VRB0MEYmsE68mxpLy5IUXOaEqrV58HP7Q3O/ZL6fDUfcBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6d0e10-06cb-4d0a-fac5-08d8f5425035
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:14:04.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxEzk2SG77Ihe9MaigYpCXGGpLKseedwFRd0VEUdAEAGS3yuaOb6NJf6tIdK6cxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 27, 2021 at 11:21:29AM +0800, Weihang Li wrote:
> Refactor the process of polling CQ and several control paths in the hns
> driver.
> 
> Changes since v1:
> - Avoid wrapping a function in another one.
> - Make a rebase.
> - Link: https://patchwork.kernel.org/project/linux-rdma/cover/1615972183-42510-1-git-send-email-liweihang@huawei.com/
> 
> P.S. This version is made based on "RDMA/hns: Support to select congestion
> control algorithm" at https://patchwork.kernel.org/project/linux-rdma/cover/1616679236-7795-1-git-send-email-liweihang@huawei.com/
> Sorry for just finding out there's merge conflict between these two series,
> I will send a new version ASAP if something needs to be updated.
> 
> Weihang Li (1):
>   RDMA/hns: Refactor hns_roce_v2_poll_one()
> 
> Xi Wang (3):
>   RDMA/hns: Refactor reset state checking flow
>   RDMA/hns: Reorganize process of setting HEM
>   RDMA/hns: Simplify command fields for HEM base address configuration
> 
> Yixing Liu (1):
>   RDMA/hns: Reorganize hns_roce_create_cq()

Applied to for-next, thanks

Jason
