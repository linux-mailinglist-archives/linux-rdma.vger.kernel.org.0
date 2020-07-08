Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E280217C72
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 03:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGHBMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 21:12:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6713 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgGHBMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 21:12:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f051d750000>; Tue, 07 Jul 2020 18:12:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 18:12:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 18:12:34 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 01:12:30 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 8 Jul 2020 01:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEN5gebVfls0yiFzAq4e1+rJM1UIyA8lS5MRs7xvK4VCRqbkoHqz9MswpL0IXrliCG0B5h9HLT2C0u3iOfm2WXkzDQbizQ6v8Vgef6ASWE+SvaXLH9I/w/lCP6v5omvceN+dXgcDEn8959bVSmBv8DSYk1+oHQ5nsbMRnEd1rQn+mFGOphjw7leR8lPjg23iBw9m4GNeVCLZHEppEfPtpGHT9HW0ss1Tb0otuhNZ7DUu6jGv5r2l4/SIHHIsd2ZMlTC8COLrs/OdGwfJU++4mIu4wSUNP2ZB2FjSqAYykxsdOi95gE9oVifpb9kT8vw9Kyg4xQfSb6CHLGdyf1daJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkhelJeQOltitmsf1XLj4Q7jG4qjRmdWAdNdPPDAc7c=;
 b=ciFr01C1sbZFuhXt36ZfP/u8CKouZ5eoqeWR6A55kMj7/pxDDiAKxVzEalLtZtDGet4yWrxpoGYELPKM+k/nm3brrQDdj0A05U5ncE8AyaF4bsEnn4xCuF1GxagRS0rUs/b8NsUZp8LGWdr9Df/SqYVVxoe2da0rakkyFkHHqtzYZ6S1g1M6OY4UZCRd0f5XAvWClNPD9qmGyIaK9epIe+93TuckiS/VYWs7pOmKA1BN7lpyp1KhzjmlWbwU5/IKdSMRcK6zKBeRJ/O6e0ire8OPvbyja/SEuKdnKv9DRjv2kdn479DIbRryo341Yqa3WTcBz6Ia0Fi5shbzMYuiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Wed, 8 Jul
 2020 01:12:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 01:12:28 +0000
Date:   Tue, 7 Jul 2020 22:12:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Divya Indi <divya.indi@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200708011227.GM23676@nvidia.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200702190738.GA759483@nvidia.com>
 <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
X-ClientProxiedBy: BL1PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:208:257::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0053.namprd13.prod.outlook.com (2603:10b6:208:257::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Wed, 8 Jul 2020 01:12:28 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsydP-006SEO-7b; Tue, 07 Jul 2020 22:12:27 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7745550a-5405-4c2a-5a0d-08d822dbfb6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594082DA97430D6E670EF03C2670@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Iwbz9boZeFwvTtvgNzjU2aFqNO7PX525Mp46HCRpxAm6Z0qYBZnVhp4hoA5C+wRd8SGVy7yq9VKkKI3MAbZ3erXWbVqsOO79oR/z9M9msS7I5U6R30mRx0ZWegfuD3KWjuEgNZjza8bIa6730QA18WSGBxf2H+9tqTdCVUfLm6S/UtDfo79eeRH9DNWz7YltfDxdYNJGLmpAPvFp9kOB2dH9d4eV8w+icw1J2oKD5X4lCB7wp1mk9C83PGBZLFhUU+3FOCk9NyFWu/zo6+2vP0WN+PmMKmFAecZ6wR6rKrC1QSShyByfxHzqhn9ty8emLkPQj+RtAMTM65qrneG/Kwfr3lfRK5PD2DWALDNAX/jgfNUand8qcQfrpNRps1EQs+YKfj3jmEEf9brLGk/jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(33656002)(1076003)(4326008)(6916009)(2906002)(186003)(54906003)(316002)(478600001)(26005)(966005)(66556008)(66946007)(66476007)(7416002)(426003)(2616005)(5660300002)(9786002)(9746002)(4744005)(83380400001)(36756003)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KeeZGC6UrOGninu5wKnxe27W5cWUuSQWdjMNEuXiDL+a1Csb0tegsjda/hQhq6Th22TEf8htqC7agqWUU0mNUJ3mYpe8OBbdLftNBp6OrtuRT/AV/p/77YyndbQSqSHuuLkH3lTMWAG1jKZXX2vqEffAM3yOm2P0ET1IMm112lbhmWLIxox3n8es3+6rKO6p+ttqEU5sDWQKSySM+nNE0ragyA1NhczRRdOXSu7ewjgQAsbAvJmQb/OSHvHpZi5tEAWgr6WNUm2LDehvphHBky6F7R6JygViraAFxFhWdDQ+80zlVKTQM9EgtBf3sKSJzAZ2YnHDtgwyReyaKtJFWozUbRlxGHFaepsdhCdAto5UqzahCZHXInfXBt1etjG8J8fuLL1OV4cAlH0aL0Hdz/bi9Faru3kerzkKwX9TxN1X12Xa3SHJmW/MtXdYSKyoESxg6PXlA2hfpXSab1FpM0FFmRgxyZw4GBy4xEhGln0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7745550a-5405-4c2a-5a0d-08d822dbfb6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 01:12:28.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBDW6iqgNtx9ahJHplLPN8FcWpfOU9BLCyS4rEQpCsTLK+igduEOJKLDsQTII/Ix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594170741; bh=rkhelJeQOltitmsf1XLj4Q7jG4qjRmdWAdNdPPDAc7c=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=lk6PRi/udo28FERfmP2ItFhfDu4faToIUMDuYsEpSuDSmjYcBR+B/duJaKtDVKyJm
         MqTpNZ9ZbWk7ofHSYi7dPG+ZoLIV2/nR3SmzF/ahnpxUq+MXFhR9jGwIsyOjNiJfj0
         PnCRw+F6A8tWZ525Ae0CAfMHF9hfxD43zraJnCTXPKZdTPiAhlUy5wx0J1KBG9RRXg
         gXJUCaR5qIZx0kN2E21q3kO+X+itex3hfif917VwAQd/UkFKfwWXFkzWr4c5G8LbpC
         RyjBjniWItyJqEgpWGLhbgXP/n1r4iunwQvyiWbh6+Y0B/9u59/Q7bFrilcaq1ZEx0
         uKt3uXaqnf9jQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 06:05:02PM -0700, Divya Indi wrote:
> Thanks Jason.
> 
> Appreciate your help and feedback for fixing this issue.
> 
> Would it be possible to access the edited version of the patch?
> If yes, please share a pointer to the same.

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=f427f4d6214c183c474eeb46212d38e6c7223d6a

Jason
