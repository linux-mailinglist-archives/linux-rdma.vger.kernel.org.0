Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1B3AF527
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFUSjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 14:39:36 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:13408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230380AbhFUSjf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 14:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msokS19QwaQX72ncwNz3pCYu0UukUxg+VegJPAXOQ5Lr8xBuqgLBaJ6iOclCW8HLl3WrPL16aYn+OAQPcDfQiwLcNA4esfs+VussXKJgKjHYcBjO5sPgsIoIdEv0bxfcXvRNgUrqITqT+ecxWIUsfCCSWOprshgugakR3HgUKi3glRM1WuemQQBRtT5Q6f1sowORGUb9rDeLBXUzUBIQc3c0fxowu7b0fZF76LCgu3txsXcmTK7o2ruL9GHMCyJ4B8iMUNxUuxzh5S/dlE++P/oqQzyq9/d2ZY2NN2vlSTdd1yUA6zm4oHHroRsOt7ZZKeLaeOOj+h16FArlW83CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75LCRwK64yL27UH7DnEtxZfk1NyVzCoeqffiFvVBijA=;
 b=Y+mKAHKvXK++c6wZt2Gy2E34MbTvsNoowEwYUOKIoV+cDPewabIFbxo8qdztVUAd8lV4ZjiUU6bcHF9NxAlleqLLQvUiZBm49hGiONpt/g0Bs8F78N1ow+eZ6ctETrZn1zAO03j/UI0sNISe+ru6+t7VvlqlzTexjGi5/21IkPxmExvwRrPgYdLGHxRe74VhnW+0GWXPTReoc/C/SPc4gKxs6KHr/B6WpjVS/eWekc+F351kmmlOavc+mQ8hkRpBhx3nUlIEFyvh3PG+QTtaGz4tpNZjFpPbZTMtfBUp1cr0jhZ1gwcddzCoZSpOQBVoaYuzbbWIjWi5PmEVWK6I+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75LCRwK64yL27UH7DnEtxZfk1NyVzCoeqffiFvVBijA=;
 b=Bh33BNvGa7KfhX6EfKoPYep1r9QJTdzqdvRFWlW3adle8917iIRrjz+shrfnzwZ50OlsoZMO3A3gBrg0+A8H3B//STXCF+66TzhyEgsdRlHsT7jAAFohAiSRSTAvJOD7FmmnqSzZoStgQcF2UiOiNaJs7oq4Cc0EWqG9ajNMNjSheCE2NWLeOx9WG9//tLEWnWwD/bC640HJclCvwVMTGOdvZcaBDiLUpB+h9HX52g2hZRZJSGwGJi7/JjLeljyA9p13M1rzH+rA9oqhM+issJKfAAy+CvCBoQkoccuhij/+kIZy163adyGn3YzdBNFht5d1E3trW41rqdA/QSpFng==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 18:37:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 18:37:20 +0000
Date:   Mon, 21 Jun 2021 15:37:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 0/9] RDMA/hns: Use new interfaces to
 write/read fields
Message-ID: <20210621183718.GA2338038@nvidia.com>
References: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Mon, 21 Jun 2021 18:37:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvOnO-009oEx-FA; Mon, 21 Jun 2021 15:37:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9ff42b-9bc7-47fc-ced5-08d934e39a1f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB519241FF7BB56A74D7AA95B0C20A9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8ZQ9a77sm5XFFsMpGuO/i16ATrvZLUfCPcNWQ/xxVMAWBjKNrqvYGq39jnEjkc5m4j+MyPIHQWo5R4uhkFCoLgAyCDv3XPGAOAlwiEwpkqOw+1q+HMp8n3Jv7h02zRGjtI+sNH8/Pdc8+TIjE2co4V/E4f5ZMuWtQbdT8iAVDXPeEqb2/mNff/c0Ius7L4+DDf+jI/3ulfBrKwrn8wrf2vE3rO6q4h/dAvUEzCE//ZGaG7I/VCAWhKPBjg26XEiQqC373O7RoK5bS1rk+7fqqVHXcWv/TUmg1z3Mx5ey1nztskBPSA8UBQlsGXO7BY+1ntsHNHKcwItXmtETIULeG2B17IcSHDOdAW/iykREoUK0EP/bFZNMj1jtse1XGmIlfx+2iWZosAPBEDY8c8ceCqNhDDE0C0ER9VCmsojJfgbK8sL1nnoUPZJCSRmmbcCUbcNhJgJzly6PbjVSJvpW347sNTqQkeGs4UtcQlcqtd643V7+Bb2DF4//dToOYz0O6otn4nR34PpF6rKCeGLRTNcFh1VHIVi4EhbfIW6t93r88DoL2SQvoFVsVmGsIR+tmC/4V/HmwO7OIGfY4TM93qWgkdHaakn45IdVQg5qZMqBKiWD5NhS9raKgkArIzSBBLoVe6pLV3svrTfNk4q9Yme8BztffuGjQtsHKXV2F2i5Fe2yJW320qmkuXiIAbqPXVlOTAOPHJaSBbfG+pgSdswkk4ipWDW3oNjxkiS1Qj4/fzJNH+e34oKu8aVkS8B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(2906002)(4326008)(38100700002)(83380400001)(26005)(8676002)(966005)(5660300002)(66946007)(8936002)(478600001)(66476007)(316002)(36756003)(86362001)(9746002)(6916009)(426003)(33656002)(1076003)(66556008)(186003)(2616005)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lA49lrPlAiZBcwCtaNyIKZr23OCSDLhk3+ClmYHW3sh/54pGE/985whmuKaw?=
 =?us-ascii?Q?Hujq/dk/ZZhOKgmqOUYeABUeF+Nq1SuiqbIa7ZCFL0b/wjzJa8QutYC+ITFw?=
 =?us-ascii?Q?BuF5Ggyj60eQCpy2V7gqvTgJY81a+DFPhmCfRwFcZ/v+oLNuBk5Q0Rp2MXB8?=
 =?us-ascii?Q?AGaJ+U3rQDs/O+M5tUJJ7La++pu4wNU7a7ejxI7pALYYlb6sqxUBv9rOm4la?=
 =?us-ascii?Q?K2BQgia9OoeFVOpXhCzCZvBGUJOKoE5EKnDP5S+zfDr/ZQx7O4NUrz7FTWN4?=
 =?us-ascii?Q?Yz7PgccpPTJo5rmdNLp572hNm2Ciop85RUllTWs0fAr9cwb/Au8CTEfPqC+8?=
 =?us-ascii?Q?biMC56gAdPRJ+c/IXsigZRTZI+9FGdPy8ZQXuMdfXNgkrsYFpsEv9sPU9FrX?=
 =?us-ascii?Q?ptZlg26M3+Vcnh/zpzDKTJrDD+MUpFfbNYn6YDz/XvMonzacQRaeQszfgYsD?=
 =?us-ascii?Q?N+9ZZjWKYVWDLCXWNXX/AIzXi1Du9sWplkXzH4FiAV4IjCbYcehgJ+fA70YX?=
 =?us-ascii?Q?23HI0ynw2QBL4bATHSbDUebS/1u/qeM1J9Eg99MPob3kT4sILzOkaY63r1pF?=
 =?us-ascii?Q?0LTe+9wvQOE2biCq6xNO+ScL7bGUPrnQqf6/R8GowlIK9x2ncKejstvudUiq?=
 =?us-ascii?Q?LW4AGrxKVoPN5puUdR+/sn7adeC/0S6VYY5sSMAnI++lc/f7wEpshK/F+D9+?=
 =?us-ascii?Q?1ry6WNg4nLs1ylMt0JqYDZQ7FMVd6Dp2jzCYQHhjPRETE2DoFSkeI9UUUWsT?=
 =?us-ascii?Q?hGOn7I2Cx3/EkAgL87M3lzo+njB7hfI9mou/3gXzHl4U51YSMRXmcU39Eq3d?=
 =?us-ascii?Q?hgzZmjqprmdQQHx3eoM6NBUmyTk6vTr4ePcGLDsc80B06o2eFaBTGixInfvh?=
 =?us-ascii?Q?H9UBtbLyuAhsgAxhs2J3/i01JZnnGkJPB4O5jYAY6uDkjzLs3Yg9ez5iXwZF?=
 =?us-ascii?Q?9j5xGEI+clDw+DA6Tsuo121BDFHrJSmXAAKPbDRL6Tlo8BxQHuNcRxgc8aO9?=
 =?us-ascii?Q?JO0E2HD3gjRqgvWr/FMKIT60Ii8kYUneKy0gTt9TXFAxWJ/oBZELGnCruVuM?=
 =?us-ascii?Q?/jGejTxHGKjm/+txJ+QZh4csh8EWCHFrauapS1llv5v1i4m5JmExQfsG7lDg?=
 =?us-ascii?Q?L7MsnPkOLnVYsEjEsiKVUuXqhuj4N0IU0XuOmYgdUu7I4BwF3iqhPw/A+T1+?=
 =?us-ascii?Q?N5TtG2/DgkwAyirEkHRN0mOkTU34Uy2z07eCqvPRvOWaFBoYfzP2pTWdIguF?=
 =?us-ascii?Q?UT+q2wCCYlYbSJ4Y3kIH4RBHjuOKaprj1mR2r9fDjRxk35s6ooBeGWrqBvJu?=
 =?us-ascii?Q?9oo14P3hZI0MGLQyLUwtfSwh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9ff42b-9bc7-47fc-ced5-08d934e39a1f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 18:37:20.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR04Um5Yklou0d7uD6lJk0aPmvrGLtLqE6sMCG6e0QvbxWdZAWpRrsRpLAmJ5tTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 04:00:34PM +0800, Weihang Li wrote:
> hr_reg_*() is simpler than roce_set_*(), and the field/bit can be generated
> automatically and accurately. This series first fixes two issues on
> hr_reg_*(), then introduces hr_reg_write_bool() for 1 bit-width field, does
> the replacement at last.
> 
> Changes since v4:
> * Change the way to fix the sparse warning, we introduce
>   hr_reg_write_bool() for 1 bit-width field.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1624010765-1029-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v3:
> * Use "val ? 1 : 0" instead of "!!val" for hr_reg_write to avoid sparse
>   warnings.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1623915111-43630-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v2:
> * Add a patch to solve the gcc warnings about PREP_FIELD() by adding a
>   check for mtu. Therefore only the parts which fix the sparse warning is
>   reserved in #1.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622624265-44796-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> * Add a patch to fix gcc warnings about PREP_FIELD().
> * Fix a typo in #5.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622281154-49867-1-git-send-email-liweihang@huawei.com/
> 
> Lang Cheng (3):
>   RDMA/hns: Add hr_reg_write_bool()
>   RDMA/hns: Use new interface to modify QP context
>   RDMA/hns: Use new interface to get CQE fields
> 
> Weihang Li (2):
>   RDMA/hns: Fix sparse warnings when calling hr_reg_write()
>   RDMA/hns: Add a check to ensure integer mtu is positive
> 
> Xi Wang (1):
>   RDMA/hns: Clean SRQC structure definition
> 
> Yixing Liu (3):
>   RDMA/hns: Use new interface to write CQ context.
>   RDMA/hns: Use new interface to write FRMR fields
>   RDMA/hns: Use new interface to write DB related fields

Applied to for-next, thanks

Jason
