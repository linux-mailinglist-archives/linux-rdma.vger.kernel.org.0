Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26C829DC27
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgJ2AWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:22:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1418 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99a99a0001>; Wed, 28 Oct 2020 10:25:46 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 17:25:33 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 17:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPEGUsPRb/oIhQKKvnHNfb+wH/H/VIs3StFFWinWulEOcq9IariJI9vAbm446EyOfridBUMz2dVXAMc8d3VCPdqN/igNCZJ79yao+k8Klvx/vNrQfzEktYGLCaZw7VcV3IXNDwHJ9PW8AhairVFcEeWJVNOIhth9yATDMctN90pYfxWhaHt0wXI3wa82/eskudy5wZV9VL9YtmvycEj8gt9tvwxToHQ1iuNzhltVl7QoRZSpxS0BZ0KiLie7k5FXrx4g3oYqFytz08KNODzULOD88mnxAqulGjWct0sHxGy4Ige+NFAFVg7ewaQP0QT3VheXqdMedd7YD7svGMKo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze7RtG2f6On3ErQSTJcWTg8hHurw8h7ejuX0RVHSH7U=;
 b=GlQJKuqnsxLWeKL9UMVTLZbTG8CJFs6W/2bR+RwDB47IGYrxJ30EpIqqykJNP0dGo7PVv2PBzFrU4Wb90jBh66slJstbQ9L+YVAiTWEf52xG8YKFdsw8/V9w+4+Fvu4g621+rzz4XigA/CgKFCkjkmxf2xgHG9zpEb1DjERMQD400zelTfWYsc9RaTAPxUfNV8ytVkQOdPevt6QfiquAnFbkOf9Ymnc9aZ/8QyrhK2OghhEXAB6bSTeipk4/nsJ2LEi+cI1+/qMR671ZpQkEHQ7K0z0pWFI5q67ORO4ILC6N9mYHPRWUi6yFEb44O6uPXlTunMYP81c5YxbpYyJlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 17:25:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:25:31 +0000
Date:   Wed, 28 Oct 2020 14:25:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
Message-ID: <20201028172530.GA2460290@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
 <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:25:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXpCU-00AKi6-1E; Wed, 28 Oct 2020 14:25:30 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603905946; bh=Ze7RtG2f6On3ErQSTJcWTg8hHurw8h7ejuX0RVHSH7U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oInDEIhfp7cEoHyCKFEWDIF0/0/UCJzT0ecRDg8xupm85gfGTH0+o7AWHhLWaRdaE
         pBtMwfBNbUVE/vpWidDDbWUL2D16ewHBxFFa5vnacE/o8CeYLT660UxT4KIRBnw8CG
         wOPlcPGMBYPPEm9JqDYPkcSM36m0uymnDlGjlKUmDyhserj1Cwd0Wvlmgt7oBxBWHm
         TdhW0LqKfZEUuMPLcobBfA5LK4DWSwEWpBmWiD9D0dR/9Jz8va/vCGOp1sS7hfVltZ
         5Eel3weHZ67atlfObiz13udcRF1KSBxSEXtk5W/Hq399ENA6I3g3esHrd25fbTde2C
         KhC22c+SFdAjA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:26PM -0700, Joe Perches wrote:

> @@ -653,10 +651,7 @@ static ssize_t serial_show(struct device *device,
>  		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
>  	struct qib_devdata *dd = dd_from_dev(dev);
>  
> -	buf[sizeof(dd->serial)] = '\0';
> -	memcpy(buf, dd->serial, sizeof(dd->serial));
> -	strcat(buf, "\n");
> -	return strlen(buf);
> +	return sysfs_emit(buf, "%s\n", dd->serial);
>  }

This is not the same thing? dd->serial does not look null terminated,
eg it is filled like this:

		memcpy(dd->serial, ifp->if_serial, sizeof(ifp->if_serial));

From data read off the flash

Jason
