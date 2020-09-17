Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6826DB15
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgIQMGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 08:06:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15445 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgIQMGs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 08:06:48 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6351510000>; Thu, 17 Sep 2020 20:06:41 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:06:41 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 17 Sep 2020 05:06:41 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:06:40 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 12:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIyt8yv3EZST1kKPs/AHbjHyfoTqbQiCxNURhiAoDCYUuQ4+lbxNMFrae0fFZij79b9iEW2ib6Y9bFOTuat8+5SO7dsRyrD6hDWqcvBECk60D5L381Nbawtcc1zkXfveESx13AhrmCBXgFBWKYYhekxyplwFtIQmQCxz4WkNlFCavb4l7W9OGzz0wcBnwy56ImhYv2gBCxYv/e6xuArIu9mMVF+Yl45wnK4zi46IsBr5csT7eQQOgNLMDmUHEQPBGOKj/TX42lELhwZLCypo81QvnSxT7zIJG2KJb9C/GsLD2ilEQ7ivjhsSZ6lAw/Otncc63iql6bGlRwJLwng/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIteBhbC670ZdVHk+5ST+A3MyeFMJiIUNHKfLUZu47s=;
 b=I3E7u7qsYBvif0vX3+AVNtNhMK7BywqoC8Vpal041NKdElARrdnqr2iOOMIxjnN+A0EDCeGSKZ0d6xUJUFnG6pB6waLf18z49ZzvkgYIAy6u1VSG4rUb9VGBRLpR9KJ1GaqAUcV12FHhPn7Q/lhHXKR66rk4mbFKzwc5e9qLP7k/MquJUXzE95DXGGyUsBtJDC03V+hTAw15xJFg8JsXAbRYX6STZabX+k3HygdksXPkofH0uk6+PFZGiWl/P7w9TTgv0h2ZvbnHUE1e0XfbPAQYZDCj5nBoZ57EgJWZH4aMda3PPTTlxYPULbEYqXXW0K6+ZrITLFSKXaB/Ksez9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 12:06:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 12:06:37 +0000
Date:   Thu, 17 Sep 2020 09:06:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 01/14] RDMA/cma: Delete from restrack DB
 after successful destroy
Message-ID: <20200917120636.GA103244@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-2-leon@kernel.org>
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 12:06:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIsgO-000QtP-5V; Thu, 17 Sep 2020 09:06:36 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563b5bb5-1076-4f8f-3872-08d85b0220e9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24905AB9EAC3A4E6FCAED104C23E0@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EU0CY22o9ilY6eNRITiyMsdAs9VpWh6El63NimWLIaRTyuZ1Pg7mKRNdpD3GPPmjQxAeCWxxCu50CUfBCYWN2PmSafDcf9Cu+5khi5EcYhncXabiUTwYHVyxm4aMQduPdV6uPz6M0//BqvfXM+ZtN2ufartOtPb8d4KRc7q6PkFDsBqlD1Cl2q8voe39HWCCQKJbrpTQDHh95qbEnmYsfgTNAAHY6hM6kbiUL6r1sLSpdzuKmr4EjIszoN1wmcS9WRS79yLRokr9K3OEAyg35mbWvJ2dUOzQ3bMo1ZkxVz7Tn9UtmL7+O693ICdNdLAiEvilBlQn67EG1FXzszK5b8yo/yJByoXFIQ9pZYklPsOGgN1PmCBt76rtPd8XdHjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(9786002)(66946007)(186003)(426003)(2906002)(66476007)(86362001)(9746002)(26005)(33656002)(8936002)(6916009)(54906003)(2616005)(83380400001)(4326008)(5660300002)(66556008)(36756003)(1076003)(316002)(8676002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dyhQs/dLYaHmBrV3qNl/4TPjAI6yeccwwySEI0B/QIn6t3b+lNu5cm4ws4W4U++nob8kHyZh0he4lOCMT0xCxuwTwDl3cLyhvPtSy4K/7vwaFMhIY6Fao7yMewf6dVSEHvFSoaS98veV0BBwMgN2iC/WA4JnDWzKfkCIMkpkWRrZUrOC4ZksDGGPWLv7TzAf2WxA67GlrjXePfr+FKGLsQnyHwVP+f1Z12YkVVoYLaNlBE17oLlMwSvZ9UyKWRlBQJCEO9qfS2I3sKolaPoCM4K+2x+0Lhcvqh/pW5vPVLmkqOqpoq/yBukqkQLIFmEM9jhAC1cWMbJ211vVEO6Sc3gGCObk5n6tjLbPtkbn2kT2OVWaTFkpbau+mFzC2yOA/T72DaNBiFS7L1XCRmbo/A74GMw6siBEoPU/L5Gqm/WcIIAdJ6A3NVnU652Ox2FG/HHCtiOkcQYkJ0mgHT6lA1dLbF9cJdtT2JMJqchjZZKoH2x2O6SQFjzaVR+0+xjrcAA2wjrpzANCFVpfnRteZRQuuv85ZyDNDgq4JQ/gGICKNJACjrktI+e2lAKBn/3iDNyzIm7sJat8L1Pj/o4AQ0UTJfvw98Y432iVWpUYRMy15Oicy4p+ppBjOmSMW1dcbivHYKk8QXf+zPabnrI0FQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 563b5bb5-1076-4f8f-3872-08d85b0220e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 12:06:37.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FQzx3YwkpDRdsHuhLy0A1GP4USI1sQ1Az1hQ1JlsRXB7PZjsur4FtnWRwoNX+KE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600344401; bh=PIteBhbC670ZdVHk+5ST+A3MyeFMJiIUNHKfLUZu47s=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=LnLXCHRptWl8SL2t4JwKgJkcm0ifWRhogv50i4iUXWtiOu8dL26VdexSAhYPf+AoM
         yRtlSagq2sQBDnT9Gq4RTNX9YF0ccEAYO9gQmTqjpw6sUOvnlEbHO0MtA+iHdvtAa0
         BUGhAKdOugK+NERw78oV3Ofl5rw4ZY37eXdfZIu5yLk02FZwlHqr+5IJKbLfuYXkwg
         i0d/ZFLQ6L0a7Mg0Ppn8Kb/tvyRxWL98KYIB616nZt/UL/c94tZ2YVCodS/Hmt+GUL
         qSQbeBN3l+StkkEmk5Hrsgj9/UfDKoLOuOZIzDsONCdUXMzX5nTai6J5dng6TbycdZ
         XA4VLuGNmqyYA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:43PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Update the code to have similar destroy pattern like other IB objects.
> 
> This change create asymmetry to the rdma_id_private create flow to make
> sure that memory is managed by restrack.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index f9ff8b7f05e7..24e09416de4f 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -1821,7 +1821,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  {
>  	cma_cancel_operation(id_priv, state);
>  
> -	rdma_restrack_del(&id_priv->res);
>  	if (id_priv->cma_dev) {
>  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
>  			if (id_priv->cm_id.ib)
> @@ -1847,6 +1846,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
>  
>  	put_net(id_priv->id.route.addr.dev_addr.net);
> +	rdma_restrack_del(&id_priv->res);
>  	kfree(id_priv);
>  }

This is wrong, rdma_restrack_del() has to be called before
ib_destroy_cm_id() because restrack reaches into the cm_id and touches
that memory:

	case RDMA_RESTRACK_CM_ID:
		return container_of(res, struct rdma_id_private,
				    res)->id.device;

Which will now be freed after this change.

Jason
