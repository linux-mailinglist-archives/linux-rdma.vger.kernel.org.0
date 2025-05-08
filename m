Return-Path: <linux-rdma+bounces-10156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D8AAF9D4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011DC4C3B27
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03247227B94;
	Thu,  8 May 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q8e2ZNQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E86225A47
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707143; cv=none; b=KmHTKXUNciKV2ORON5oaj3Rio30dLKU+0ngGkiVavL/XnOOQkY/l6Fq01/dQi93q1rseTPrMiF5/dgzyVty9G0/zAq/I8xpfLlAR2uIdcbyrfmiFbNfU3U3myLpdcCPgPWPxFbRdNYc9SFlgMFTXE8AWvZAEHkvueLHgiePbfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707143; c=relaxed/simple;
	bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlNeYmviP5QamffCezEnO6cMESCIDEYF+91JbCH3uhVR2NvXks3nJENUSyd0sx1FwJJ6dO82Kk/eaPFswWREbNbLU7UdgIp1peNiBFc2ThLLYNhfQNy6TifmmwSbylzRNo3AHFtBMPiLvwzIrwLgrz61ezlqgg3R572MxZoxfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q8e2ZNQ5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4769bbc21b0so10557261cf.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 May 2025 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746707140; x=1747311940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=;
        b=Q8e2ZNQ5wGrzw03gpS9N86sbZtaFdq74sMp2YzmMLtp2bCxmPNTKFbz5FXx7jggjUo
         8Sz/QqG/05dKNb8M1n1PsYOofwaW3R2PtSuynxo5Mc1rTTozEi/PaxJyA47htBYt1xKU
         37n3sOL6jOaX3FFwGDnrtPy0rwXuoPt4I6xcNCPtTchc84PfVU0sfJgpjfKXaiYfyMJO
         ikawg1zbHlIM5NrfwncAPvyf5xjmmXa6Z1S4f0PwRtiUrBLKYJ/j80eVc2CwMVE4570N
         o/jdKJcJrDB2rgtSerL1EszvuN2N9XpLj2i7nZ4viV7rNoWdB2HFK+abuB2awuNO2mNq
         l12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707140; x=1747311940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=;
        b=oxDSzxhkmWSHPJPHRlpFo7a0YdLNJaHqhQIdN5+hr1wrgEY1Z3DUwhi0D561pVPy3c
         xYyUIm5NXMiGYexY/eJoK36ayZYZxigCuwcK3C/1iWvGJ/ZLZhfDmZjRoyji40fAUdOT
         7B8SBLt4ShKxyf4g0s4/CsEI4LuN5INyjCLSCxIYBatHvEfUadD+aq/ugi8U+6YYsX8R
         20zfe8+K7dhc8ykMlD74kCAQeneOV9ucbNqcnelYEzEs2ayXBJ+560KDCcQM854GOXqQ
         yj11vYcbUZjmP59y5jl5AhxoVnI0gda9FgY+rGVSBAeD8D7CUha2ZdWEhlsxrmAk3Xt6
         PpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO6mZKvfF1uz5vnHZ4btD3kqz6JYj/DvOqw84DZj1HKnAV0xoKyBP3tdrs4RUbdYLo2FpGa2ewqHw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcyuIDsUUGrH4B9d+d42ey6MpY94Xs/szN79Dxk7+BQoU6alp
	szOspQOAU0aVyKTW6hG7sHsRWCO12w68XL9v4kmZ0omcDNnxC/r22zNXrGTFVjCQHetmQ27cOIw
	R
X-Gm-Gg: ASbGnctVwIcI1xssH++UKGDbtfpmGqKAIotzXnh50xNc4R3JmB2D3iPFK+oim0HoKbA
	jB2n4q47vjZzkpp0iO9SQGiaBXgFbAsQ80W3dkYhAB1q8fa1vfR+BE72iG6sfbyjXwVIt/K9LiX
	uNXOGFLi/lrSy5pzQgGll8T6YYzpBGPGdZZaQsWrtoqdof2FjAgJzLSSIm7fjBRpyCrvgumJZ+p
	cKNDq+YkNoc7jgrS+Idmit3GVVcJWmsdyzrshPuLWy8DJuFTZwrMEzbJcql3EoOMkGkCoocRfyc
	53gcXQ/2xxUjaOJiLP94x7UACc5RU1mR+bhVWzAeL7TfbLWXnML8rjqv/RRpYt7k/+k9V114IRM
	zFGjTehGv7OkoDizV
X-Google-Smtp-Source: AGHT+IGjPkkheV8apeeXL7LUq2iF5xAtFaXB1jDnzmyHtoO9fJMw0oyoMGJs/ppBBX9R4BQ+OduBOg==
X-Received: by 2002:ac8:5955:0:b0:48d:7cb6:4010 with SMTP id d75a77b69052e-492264f43d0mr96133521cf.23.1746707140464;
        Thu, 08 May 2025 05:25:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4922126b6a3sm34885331cf.21.2025.05.08.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:25:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uD0Jn-000000001gm-10DS;
	Thu, 08 May 2025 09:25:39 -0300
Date: Thu, 8 May 2025 09:25:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Message-ID: <20250508122539.GA6371@ziepe.ca>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>

On Thu, May 08, 2025 at 07:03:03AM +0000, Shinichiro Kawasaki wrote:
> One left question is why the failure was not observed with rxe driver, but with
> siw driver. My mere guess is that is because siw driver calls id->add_ref() and
> cm_id->rem_ref().

Only siw uses the code in iwcm.c, rxe does not.

Bernard? What do you think about this analysis? I've never really
looked inside iwcm.c..

Thanks,
Jason

