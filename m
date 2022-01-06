Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409A14864CE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiAFNAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 08:00:51 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:45024
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239319AbiAFNAo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0jn3J4BbQ8Y1CtjOmFnturZVGH4+bhy6cfxHqzXAa5PveTsyn499pW9WkybaWEhdcvPj5n8Kmv8hVhBXdhiJMU+Ktkj0nJSgl8FvLe+Z5ZO44ACwsAm/0Z49HdghW0rcKSPmkuRZVV9nqu4uIBx9uNpYrPfXvjq747yBdrR8VXa7ZfkVHJM5ev31/McSQwZ0wZMkMo7wo7Rhh3ZAuiKpCdMmpX1W721gUnfg8+4IGytbXd/fjYAS5hFvns8j4pInXN6oZ+u/bs4rJqcOiAt2lWpaa5dLQtJPw4G2AcLohSgYBM5CfIgcXf+Fnm4prNingUSa9d8N+/LXyCXSfXEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSQo8KW5MhZs0b+P2iFRFr0hSVWWgawxsWka+XBGpGM=;
 b=bXm+aLfY3V1zNG8Qc+BXZUnZFAFef350feOBiCG0GyhhbOSGxRWuQbyy9gjDA4bSmagAdfThneiD3lLRRp4RZ2WcGraUdBBeWOyABb+jqRJdFr+QLY+FUqb66Rsii80R9+JtfvNw2Jd34VZ+PSJcnplRJXfbBN7BNeQSkrT1rZ3TTxcUCd0SGuHp9+W6C20JKYTIwN76jNqtmQiUvxi5548eoUs6mvedogUlCPyRsGH7Qv/SFRpMk396Pn42kcdR0mo5bgIAleEjB56eu+VkWVY8A8fyX74zq0pStk58EG4mAWL4kYamanS31rM88l9nuc0Wu2nNjn4q1j3VL6eScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSQo8KW5MhZs0b+P2iFRFr0hSVWWgawxsWka+XBGpGM=;
 b=SOel7uHv1mb0FUFrBnuIPJSCYFzChOyroeohjylpDmInedUlZVnX/2wKP+5p5I0vO502u+y9smvVpDPmrkoZzzYELg0FTFyAk+XDtyIpmfSrgpc1mfKct63FQlmhd8RQK9/YJNAOSScyE+hU2kMmtUg+n+sQwA2COGPOdKUmpls5FdmkZNW+S0sF+hOo3DeLlIfZ6BRNnlzAjqSf2Zn9/GJvno5twWiJ40emvtldm40ZZw6Z7LUctkXjNIWhDT2rY6x83prR/kQNuBld2nKdtHyA0q6v1lOKOJbR95owsdfJptm2pCZI5/FYnqnZ5IN0wsiSo+DyvhotJ7MIX1lu8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 13:00:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 13:00:41 +0000
Date:   Thu, 6 Jan 2022 09:00:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220106130038.GB2328285@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com>
 <61D6C9F9.10808@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D6C9F9.10808@fujitsu.com>
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808db726-582b-4407-1060-08d9d1148afa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5205C93DE26EE094AA7F94C7C24C9@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEGip5PdeBgSAyrBiEnDLWI10pavWBqwyRwgNqYAnJd2xXdgvJWi4MxqiKFocTpT01kFeKuxwEmXSOSU5OrXy78CAjcmTFWR0dYTV3NcW9J8cB6j8PvWwbNdi4iMxyTo3/wmZXGQZ121wkDpx1To9n8A6EEpaR5dvsgZyzhJydoOAVBWIHpL7n9J1Y0EFcsrv3tUjcU6Nb86Oz174H6Jf5X+AJ/bEXfLPudKz1ZpqO69fOzL0JGuHmZfRcO1+kGsLgPlqjnEt+vSTeqefxE3xXn/m0ofDQT7GDVVbV8pZ5HGJhs1Xmyg3sJss9+lJebE0cv8JIRhsgVtGqpVIH/STdozR4p3Pym7Pr2oIKruF+eRTnY1ghyKLsq4BmI8ponSzJyY2qcXQ5lzmDIJzCzdoNFImQJ0DY03nSEz8fyLQuqFno0wPHeE5DvZAZ64lfYXj6zXO5rwu6bMcM2w5g2bQ9SZI4SyCNmUKepiLmwX0wNl8NgLF45rbTlVP6M42ormEAKfE/bfnUVILI8LrIfnlyLGt20lUqqt/Z2Ls/4T/u/DzbtIuP1JQ97VWjxqFmLwSQF628VM5EXyiOpZ66lLrO5KqDNj0NBgLb1QrzmBlYAgH8WwwKEahsCcuarOEkdJPqGykDin0q8+X5tDoN+oGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(316002)(6486002)(8936002)(6916009)(6506007)(4744005)(53546011)(508600001)(26005)(54906003)(6666004)(2616005)(4326008)(6512007)(38100700002)(2906002)(36756003)(66946007)(8676002)(33656002)(66556008)(66476007)(5660300002)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zS4FYvOhZy3DW/iJGy1FLLXL3tw1ub96yh5CMW2AE5cpHTQAKcWahjQIMwee?=
 =?us-ascii?Q?OVKIXHN5lVitrRk84HMg/XrnXYqG5E91q1VtJdwIcFM/nESFd1zl0m/48rXM?=
 =?us-ascii?Q?FTDgv5BarbqPdm+xFnBLUMTFlSqPtxKi8fG2/MJF/Jr8xToQhVbELVl57wtm?=
 =?us-ascii?Q?l7EFLf++fMrhjdI8e6bOk91p21v6X+X+c0yDxukkIvUp2gf13HAyTik6+phc?=
 =?us-ascii?Q?FdOCq6vVd/ZTd2oU8b/M2vXjTbgd1t/XwKvmeaul0YApw7fEx3G6h+yIKEqF?=
 =?us-ascii?Q?/ASPe/kQuZ5+zQX5ClHHWZwdzkanTJrFM4x/x3VlumBz/soQLa43KsA6rbpZ?=
 =?us-ascii?Q?Ct7uNKZ7ICkh7LIsTO9zZeQRdHkUvCCxzn7HHO/E+0WlMLYg7/LF70ljUs2x?=
 =?us-ascii?Q?bvMKE885o+SpALct2B281U7+hM3Ii8MoaV0NTKYDvxK5vK9ZsW7Npw5QhucJ?=
 =?us-ascii?Q?rEjuy5IHfXzotBup6Ugp9zaQX0g3c4qOZVJd7nCS2ieljYe9wwlbEaMmKeBo?=
 =?us-ascii?Q?hDdWx0AWbuYEzdjDBYTZYaMNpreo0gbNK8zZgJQBwzrueIB7BKcEYvbu7LTc?=
 =?us-ascii?Q?SK2sdawix9IGsi9UW9H+uCsbXEg9TIj7PHT16fw+oP5RAb76PXcZOrOFrNK9?=
 =?us-ascii?Q?fSBOAYikbscpJGUhAL6/PGKi1kivFXlXc+ud6PXkHRIGy58CXec/oAJlNhaR?=
 =?us-ascii?Q?qQqIW4aX1nYPkCt78XpwL3ZdQ8H+WYoZsAOg4bEcXtwTjjF0jtFDqkB07nLW?=
 =?us-ascii?Q?iRIEmu9VNwEhxLdd3sz4+euwLnADTk0P24XEgGEecc0W97P+23mEZGfYgNho?=
 =?us-ascii?Q?3sftNGvZExHVPuFUBfUha7ydDhQSjsmXDSKT9jy29hG+5UAE3DzvCK2cMbIA?=
 =?us-ascii?Q?+FLZsv/m3WmmwFxyYLxHzohWFAzucfySEW1Co9G4/345kai/4lgWhgw0YD9e?=
 =?us-ascii?Q?WekcMg9Xv+FguvYXKLQAvddgyZdeQ83AhabZDGQB0JbyyDIJ8zjQXvsITgE6?=
 =?us-ascii?Q?h/3Eyzfw8zgDJZhG8Edrwqzb87LwyzrUIheLIBC4xuFomeg6KE3xxZh0LMet?=
 =?us-ascii?Q?Ukvc6Mz+5oSBXQQ6KXUDLzCVzhnfUB/dXLqBMnmf9sCgW94naR0+ZSKsD1zi?=
 =?us-ascii?Q?j0wmi1AOHrL+x9/Yd5ciQBy3D1HSAE/+Ca7hoDXx2BsofDFJYxRmJUvMAYyc?=
 =?us-ascii?Q?Bv2vqzuU39WPWhNKa75rBW7LkCl/B3ppeWME21b8ZQ8B733N2PMbpPBkZ8VF?=
 =?us-ascii?Q?iFL1W4wGwDafg92FZ78jdxxjIEfkWouxnE9Fzs4GaYP5e3g9UItsJGTs49hp?=
 =?us-ascii?Q?ul4RgE1bPTNUmmMPMIyg4UW8zDJZRc1iuaM2Pl/wRmnENBf+VhTwH/jT2Rbh?=
 =?us-ascii?Q?n9w3sJ0qWboaGmCQtQ5N+GQSlHVxjvfZw14nLfc/eDu5BgbR1hLZBZ4GOCJq?=
 =?us-ascii?Q?KYIzGrHaeMrtI0dFrDoviXAGAWgblOLtjFr1myr2hUTD82yxiRB0dtpKj/52?=
 =?us-ascii?Q?e3VUex8fwnah1hj4x6P0MAvntGfNIeAXbbcsqk8uYQ/cHCSke3D4JQpxA9Mi?=
 =?us-ascii?Q?8Tdkq//msMsEJx3mCkc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808db726-582b-4407-1060-08d9d1148afa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 13:00:41.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC3QNmDs/SNcvE80jCyXqfhL4yxAph4UDs8GCEYxc2ZqpbzTUNMRrM1uAMO6//YD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 10:52:47AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/6 7:53, Jason Gunthorpe wrote:
> > On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:
> >
> >> Because RXE is a software provider, I believe the most natural approach
> >> here is to use an atomic64_set(dst, *src).
> > A smp_store_release() is most likely sufficient.
> Hi Jason, Tom
> 
> Is smp_store_mb() better here? It calls WRITE_ONCE + smb_mb/barrier().
> I think the semantics of 'atomic write' is to do atomic write and make 
> the 8-byte data reach the memory.

No, it is not 'data reach memory' it is a 'release' in that if the CPU
later does an 'acquire' on the written data it is guarenteed to see
all the preceeding writes.

Memory barriers are always paired with read and write, it is important
to understand what the read half of the pair is.

Jason
