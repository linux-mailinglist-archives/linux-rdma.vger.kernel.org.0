Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3F26CB19
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgIPUWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:22:08 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:13256 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgIPR3J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 13:29:09 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6249e50000>; Thu, 17 Sep 2020 01:22:45 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 10:22:45 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 16 Sep 2020 10:22:45 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:22:44 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 17:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezcrGONgW6/Yfyw1iOacTymlwOnfcfNIx6nz7IcpaN+1XyE36Bs4LVypkJTfCwYrggsQzuAA8YZmAJprqToLryZtW29f4W/9m4TGm1ZN26bGJWyx+nMwG1fnFdvJRH8U3JuLrozoUrDEQFn/OvviSan1g5VaZNacxe9Deq1NfwzrxVw6mAYKWyVGTpuBM7aovTKY5uJZyy7snY0QGswakFl1OKRM9OjDDCIVnRdMApnaqIY8t58dUfP1TeT5i4roNCANsSoUe2Gbfx9vAi1gzXAGgIPgCmIOe37q9u4eIB7Dq+A8dhA7GiJx08Y4tF4jSaiWE9kmyp/rJoYJL5XqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc9+LLliqa4lq1itrexB/e7D9i8XKUie42Kj5wSC0Mw=;
 b=bKlqIVJJhj4dGtjOgzQtlFMF/D56Jn/qVA+dd9oDpTfpRPkDVA5BG1Vxbfts/SKql6HRnTSekj92yktaVE+gkJ0FcCjOMJUeVjV/RS8Yb+hgeF75B8tCJO5dQChtfhVEfkdbqxt7V5evI3gzQVkHv4pKCqrpIo15B+7SdlLSuHhyqemVZX5zDCx/pisPwiG3UrvRpoP57dVMHDqwXwgiWQ/tbjOELi+toveTlwQNUcp1uwAnMJgGu7+Oa0g96Qgc5MitE63eF/uoaGKVFkP/g+Gvbi/wtGaTPg4i1awc+/WsHsLSdn0A0UoVfpRz52+0fH0HnNjQMWTHAif2NhMPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 17:22:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 17:22:42 +0000
Date:   Wed, 16 Sep 2020 14:22:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: mcast bugs
Message-ID: <20200916172241.GF3699@nvidia.com>
References: <10c076fe-3a45-d42e-7e33-218ccc635b7e@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10c076fe-3a45-d42e-7e33-218ccc635b7e@gmail.com>
X-ClientProxiedBy: MN2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:208:134::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:208:134::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 16 Sep 2020 17:22:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIb8j-0005en-5J; Wed, 16 Sep 2020 14:22:41 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4d1249-a999-4cad-04f7-08d85a651e6e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3596E7B401F4364169BAB4E5C2210@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOul4D5KYpjPoUJ51DPSyfysQpWHxXCQ1kMx0q/UPdFwSw3W8iWk+ugk8OS7mi4L+J4LV7RD7X5+kUZlOwuNW9BJyTGjMWzRh3lWJ0Knz86UlQVldaVRACDDHCfG5IOIe3NB9IsUygn4HelyiFW6pqVzA6KMBtdt32NsKMrH97D7j7e+KBtpzgh71BlvNZ9rchxOZnowxRFpTfk3xlV7qvMIT67FHNdk6ptbJm//3i+QBvNhYsT1LLMCjn+bsAr6TUjDvbue5onJB6PX9UF/0aMJu/NFZpMhyXvkERBXqTYqY0Q3OzmAvUDeRdrj5asXI7CFSU0T1JjUCrc4WCj/YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(9786002)(316002)(186003)(8676002)(2906002)(6916009)(36756003)(33656002)(4744005)(8936002)(66556008)(66476007)(26005)(9746002)(3480700007)(4326008)(7116003)(86362001)(66946007)(1076003)(5660300002)(478600001)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fJmOhxA67Nc4my+T+x9tVrnOQ6dGfTQLCMzonp3gOvpA/9pKP3BJBuROupjgxBpQ4+kT8OCBxBv47pZ2vKnBMukENLV8YTVlmbnQdVW9MuiFTmUmQTJc8V6Z25cEKQR8smxdc32wR4m6E1OYScMdnZ94i05UHVwzbyrurVrCFKXe8pW4a3jFHfQAJgq4oOlzaJ5nO949E50vZmCoA87n2SQrulXXaE4jumoek7bMmqqYFi8Gv1g+NUlnJ8yPERz78I8Y6jjLAG5UOy58KtHDEzHuSx3hAYLds5u5Fh9362hzxopbEvX5UCTZ8KbA1ezVMjJ0wHJYa0lVrdpU0eNl6lmtx4Dq7IaVIVX1/qksl+tQcE+5qQJFQbHr/X/wTCmyd5EJrCZwLhX01e2f40i7PkpoAI45d16e0AhI6BzLpwP3rV+4qnhOLgqqASfz5HoQQfJLS6fOFO4vDjPQR+498p9Jrj65saPI5xBc0VMD+kBLIY9SDl+2DHtp/NyctI7TUTMTeR5YIn/kCs2m1LerdpNCggTujoVlOA98MYr8jrNV+S/CH1dvKOBJNvlj71KuzS+ubW/+dPhAHiD6bd4N8fYDxKTSMPLtcbrQzNnLfTd8bkp613nJHnT13qPqpK3PTqMUuquNazqO92EjArup5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4d1249-a999-4cad-04f7-08d85a651e6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:22:42.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHVes+shNkHLeO6dqqBtAE4PsxeVEBBtchzxegm6uAZvzFBC82gZ2eU2XV/xaf1i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600276965; bh=vc9+LLliqa4lq1itrexB/e7D9i8XKUie42Kj5wSC0Mw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=c8azCvPO7umc4fxo2Damnp253B5Q24ScbOi24v/GG2dCNIPNLwnF1IcjKDGlEN3Gz
         uW8Ugonupk3Lm7vCSz13Qa5Q9a3mi+eSCNjmiD8Qcp1cNrW7BtpGby5QShyPW28oda
         bQZ36MUM6Cb5kyIlvQPIFRWJPglAfAlCp14uqx+0p5WoFsivq6iPg3RjR3XKhenCyV
         gVc6pkdOM+qWmP/X5AHFk1IPEQrT9Qbr4gK16u5R5hkFeu50M5PpALOGv5ZRm6KCPs
         osCz4/7o2I6BvGiBUGAQafmQly/9Cq8MdsUSYFD+3gR/LKIAUJHAlck9j/eWoitGUw
         wS3z7VBf5uK7Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 02:34:09PM -0500, Bob Pearson wrote:
> Jason,
> 
> I have fixed the multicast bugs in the rxe driver. 

Sounds good

> Aside from what we discussed last week there were some issues in the
> pools code. This work is done on top of the memory windows work
> which also changed the pools code. My preference is to wait until
> you accept the rest of the MW patches and then submit the extended
> API work (which is done) and then the multicast work but I don't
> know when or if all that will happen. The current status is that rxe
> no longer fails any of the pyverbs tests and only skips 31 of them
> (DMR, XRC, and a few others.)

Okay, it seems like good news

I will get to the rxe patches eventually, but I don't know rxe very
well.

Jason
