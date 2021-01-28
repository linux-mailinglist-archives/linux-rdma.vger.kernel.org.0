Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0DE307730
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhA1Nff (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:35:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14203 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhA1Nfe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 08:35:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012bd7e0000>; Thu, 28 Jan 2021 05:34:54 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:34:53 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:34:49 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 13:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7STQT/CzWJ7Ax7gC1VCsO1uZKjk3q0wygN8nn343kYqbCRgXBj+ikweWUwVnKMRzI15RdUz0gLuq9CTyQEujaZxGhrp+ol6k8kg5mbUVQI7UuhGu9Ul2p3/CR+xzNxWxh+BAJ+zFukd71EYp9nm+wyRlsb2MB34UoWAR5hEZ9s2tUKuPTRTIIz3docT2Qs6L7R1HnEU55EzogYyr6oMYmJti5XnNOjMjyWmv8REHYyCl0PkjSxWbSIQ0WnmxGftM09uZnd6Yuwbp9Uq+54DbTZP5OFmQ3y+o8sdvX0IqCnBcfzjoPDUmNOXZLhd90K9oDyLN8In/c9m/SJ8Z6pHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASrQlhigP1OmhWI1dY4ajLnBGRvQlhZiFurR8hMhOs8=;
 b=MkOkD3SiRhWvkKsBlXHSuf+IEE3X+JXqDvMbk1SK9RMpu+tkGb1xccJpT31xHVknIMrRMXyh++rODGFqe5FVFNwGOMxS5C0/PJN+ESBbHwq3JBxFYKOpqGM0qskyE7ntv+woJHXWWxup0laJeG9dW4M13+WY5v7M8SvwqTlIS+Cf/eezshMHJgEUdeJuo2/db/WBNQOsxStFIjQSJU9Tld8blTf1oRKgTr3VWf3sgkSs9yBOZn6Ab8FLBx+7TqtBteqyYv+Y/5JM9R/rZt6dc585ZIX5WtYTfRiF469eRHdhrwXZVTXfou4veptH5xQFUi9dGhFMSTF7qqkDm47jcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 13:34:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:34:46 +0000
Date:   Thu, 28 Jan 2021 09:34:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 4/5] rdma-core/irdma: Add library setup and
 utility definitions
Message-ID: <20210128133444.GC4247@nvidia.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
 <20210128035704.1781-5-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-5-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 13:34:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57Rc-000358-Md; Thu, 28 Jan 2021 09:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611840894; bh=ASrQlhigP1OmhWI1dY4ajLnBGRvQlhZiFurR8hMhOs8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ByQYwiVjP+4a8uKSu2JgjKNDgPUlBvUd2dauxLsLBzn9DZ+QLBF9iBiKAHy7Jx+Vv
         QjWseElNZaLOs2hZBJSHuSDeQz1EQaUTD48i/WDh+BYIeP92M9J45Jf9EsvbUsZSKN
         QphiIyYVdmdAexTplakpUMi6C4wZuuiZzYotk/iLZ2hthrRo8wKITgZh6E4eDsDcCg
         coc1k31INWQvtS/5G7uxXrOBmZiRWzkTKT6p0KcIH0ycb8+tLt8bQC44q+0YPlXRtk
         USXFr09d0E1YK50CzrbReiBXy/v+rT3P10bo0v/7GEkZpV8kBUuSMOj6vHrgJV+Wyy
         gih1PaIAulB3w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:57:03PM -0600, Tatyana Nikolova wrote:

> +#define INTEL_HCA(v, d) VERBS_PCI_MATCH(v, d, NULL)
> +static const struct verbs_match_ent hca_table[] = {
> +	VERBS_DRIVER_ID(RDMA_DRIVER_IRDMA),
> +#ifdef ICE_DEV_ID_E823L_BACKPLANE
> +	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_BACKPLANE),
> +#endif

No #ifdefs ike this

Jason

