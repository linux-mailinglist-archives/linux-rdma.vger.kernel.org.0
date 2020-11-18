Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB32B7DC3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgKRMpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:45:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3028 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKRMpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 07:45:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb5178a0000>; Wed, 18 Nov 2020 04:46:02 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 12:45:51 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Nov 2020 12:45:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewv9zhcBuDhSE5vUuU7+v9LARinaUNUhAvsBYLP7wMB8Sm3aMBz8IaP1bS5ct4ASgeIoVBBjUG9WdtXBsbI1Ig6Bff67h0yy2wXZOZckxFn0KX/iWOCOF7z8pDN2vx0TIkinyQ6x+AElQAkEv02uJ6HASD2E8qPl59LwTI3q7orsxVDrLsPOQrnnco71tyq2e3Wqe2heyglfYiuOWUkB7kLvv5m86DKwozHHUbvqYdWvxE9D7fmb9lDbb6CKtnsndUc448VDc+enaEfyq8AlTompN+7ALU4eL7wlg+kLsWr4QxA+pMtwy1E5RjSjTgHQ8Fj7nZxUwd5R1Aqy+Pw4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzTR/zUXQACf9bBnloifwCmpNrWt0Y3/vic1Ngm5LL0=;
 b=d5XTAGCVWT4lxd8+NrbRard1hIYcMWmpHyrklS7dFOYEljGEzfHNjvax4dhonH2hQ0YQ3m9UtnDX6ft95mlz0jtGwcybvtuYWK42w7lDsoiZkFbzaFcN7cEavdIlRVK7aMzTeJccrdOHjOuYSfwJyo+azVhQwNiAKIvJ8N5wAY6+RWJbO0jbYIwJQm9uyH8fFpwYq/4ukbAEMlOGB3rDWRUEFCS8L9v9JzAUQ17du9dHy2IWY/kvMMLftk41CnOeC+fKs7fxcSN/0kRhzf06KelxiDrzeuZL6fZ6m+APUaPnRAEfExNdQIOTsSCO1YzHVPds/T9BzPjfdhaXnplSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Wed, 18 Nov 2020 12:45:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 12:45:49 +0000
Date:   Wed, 18 Nov 2020 08:45:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 2/9] verbs: Add ibv_cmd_query_device_any()
Message-ID: <20201118124548.GY917484@nvidia.com>
References: <2-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
 <bdb30557-27fa-3ea4-39a9-4bdb136ff798@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdb30557-27fa-3ea4-39a9-4bdb136ff798@amazon.com>
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 12:45:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfMqK-007fwz-8k; Wed, 18 Nov 2020 08:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605703562; bh=FzTR/zUXQACf9bBnloifwCmpNrWt0Y3/vic1Ngm5LL0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=j1EeOFzRZjPUAaUCKfIhC7rf613YorZyhoZk9a7Zp5Y6wcGpwSj9I4MVQ7rTBmEDx
         JjyKCPPox8P+QMMxaui9YL0xcnLMHoB6DoY8jpM3dcIhkQkscMiaLmE6UqPuC+qDg4
         lH3ElO8SbWYl36OSs4jBSxAUCUaJi9ftbvT5fNfF5rC74tLzFRBSFoC4O0L5Wls0kt
         YdRbvcP0vBbVJsnJoXoXIHbGsmYJwBaHMs6x8p65S9ZrlpUlrQG8EbaRRW9orVPJ8m
         SzOh7LHRVlY7X6ppwZYZYbY0Z+u+Hy78R4vLxiUnQLwqLC0bEuJKGLmiVHcXHW94eK
         8R+qlqzWVFnxg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 02:43:57PM +0200, Gal Pressman wrote:
> On 16/11/2020 22:23, Jason Gunthorpe wrote:

> > +int ibv_cmd_query_device_any(struct ibv_context *context,
> > +			     const struct ibv_query_device_ex_input *input,
> > +			     struct ibv_device_attr_ex *attr, size_t attr_size,
> > +			     struct ib_uverbs_ex_query_device_resp *resp,
> > +			     size_t *resp_size)
> > +{
> > +	struct ib_uverbs_ex_query_device_resp internal_resp;
> > +	size_t internal_resp_size;
> > +	int err;
> > +
> > +	if (input && input->comp_mask)
> > +		return EINVAL;
> > +	if (attr_size < sizeof(attr->orig_attr))
> > +		return EINVAL;
> > +
> > +	if (!resp) {
> > +		resp = &internal_resp;
> > +		internal_resp_size = sizeof(internal_resp);
> > +		resp_size = &internal_resp_size;
> > +	}
> > +	memset(attr, 0, attr_size);
> > +	memset(resp, 0, *resp_size);
> > +
> > +	if (attr_size > sizeof(attr->orig_attr)) {
> > +		struct ibv_query_device_ex cmd = {};
> > +
> > +		err = execute_cmd_write_ex(context,
> > +					   IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
> > +					   &cmd, sizeof(cmd), resp, *resp_size);
> > +		if (err) {
> > +			if (err != EOPNOTSUPP)
> 
> Are you sure about that?
> I think older kernels return ENOSYS.

Oh, that is possibly true, we changed those at one point, I didn't
test that far back.

Jason
