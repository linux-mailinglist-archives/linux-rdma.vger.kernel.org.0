Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0590C3927A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfFGQsU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:48:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37308 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbfFGQsU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:48:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so3032194qtk.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHd4Nk5GG1yg9EjBi3U2iIqgPqcue9CEP2IixUaKIHg=;
        b=HShwDbc0H5dnOD+3mnE8apmwNDi87a6O8iWNDFHVI41f0BtAFhdbZ3ubMt97A2w2B6
         FrVr+6IoYm3VFtldZYenkwZqLlFI7j6m/V27gLKNAFfQ3+h7MRhwPem3EDdIXRM+MG4J
         BUR+WqhHNGVRoJe9E61QHUitBzCRt3xGcSfwIGi6p0JtMmSX5D0hL4ifk09MV09v9ni7
         0OzkycA8J0gvqV6qZYBvoavsZLMMa6I8/Y8R5bN6lm8HsJIUfhJvrbhEz3RWUrwWWKK9
         1BERDI5mfRLptUYNNRPVQ1aDIbVMSzSxBJTS1/k3lf41YD66pPSHx+mMFW84/mdkO5gH
         EEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHd4Nk5GG1yg9EjBi3U2iIqgPqcue9CEP2IixUaKIHg=;
        b=Plg/FZ9II6jEF3+lqlQR9D1BbImCQE3ODwQhjH/jL7+DDrXMmoXjiaNZxahQoeyN4L
         HvHaEBhAlEHHCCCACC0M3eWdNQjrh+BlmcnftFVP30r9TGUsHhzjlzJD4zCHOFLTOZew
         krPFGo47iJft9IKXCU8kKA2NZay2wwVHXmfjsPRXf58kQk3y5j/PBGz+b3zjfye3wTW3
         mYyErrqN/7c9DnXDxQMNoeuOG8yW8QCpSHeHVcZk3kf5dRysx2NC6IEadBqkut2pLWlp
         /JxA5SgAlTEGzelR00rZ6lVFnLgS4FdmkWdodMzYSi7n7NiWJktcBO8vByLhkzT3YlIG
         pD7w==
X-Gm-Message-State: APjAAAUWsOH3FuJe0pFjVoErwPKUK8crdq2mH6xn9D6ZdTx4wkZ9+7gf
        cdzcwOxmlkbc/6AKe3LqT6s22g==
X-Google-Smtp-Source: APXvYqzDrYpuESDq46gdEmtDsLgyR3aIlZ3ddxU7d/I2cyHtOVtUIpR5Ucm4wYfOdsaHpsoo2iCTtg==
X-Received: by 2002:a0c:ba21:: with SMTP id w33mr45141944qvf.122.1559926099696;
        Fri, 07 Jun 2019 09:48:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o71sm1675651qke.18.2019.06.07.09.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:48:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZI2M-0005ms-R6; Fri, 07 Jun 2019 13:48:18 -0300
Date:   Fri, 7 Jun 2019 13:48:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190607164818.GA22156@ziepe.ca>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559285867-29529-2-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 31, 2019 at 02:57:45PM +0800, Lijun Ou wrote:
> +
> +static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
> +			      struct hns_roce_mtr *mtr, dma_addr_t *bufs,
> +			      struct hns_roce_buf_region *r)
> +{
> +	int offset;
> +	int count;
> +	int npage;
> +	u64 *mtts;
> +	int end;
> +	int i;
> +
> +	offset = r->offset;
> +	end = offset + r->count;
> +	npage = 0;
> +	while (offset < end) {
> +		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
> +						  offset, &count, NULL);
> +		if (!mtts)
> +			return -ENOBUFS;
> +
> +		/* Save page addr, low 12 bits : 0 */
> +		for (i = 0; i < count; i++) {
> +			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
> +				mtts[i] = cpu_to_le64(bufs[npage] >>
> +							PAGE_ADDR_SHIFT);
> +			else
> +				mtts[i] = cpu_to_le64(bufs[npage]);
> +
> +			npage++;
> +		}
> +		offset += count;
> +	}
> +
> +	/* Memory barrier */
> +	mb();

Didn't we talk about this already? Comments for all memory barriers
have to be very good.

Be really sure you are using the right barrier type for the right
thing, because I won't take patches that get this stuff wrong.

> +int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
> +		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
> +{
> +	u64 *mtts = mtt_buf;
> +	int mtt_count;
> +	int total = 0;
> +	u64 *addr;
> +	int npage;
> +	int left;
> +
> +	if (mtts == NULL || mtt_max < 1)
> +		goto done;
> +
> +	left = mtt_max;
> +	while (left > 0) {
> +		mtt_count = 0;
> +		addr = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
> +						  offset + total,
> +						  &mtt_count, NULL);
> +		if (!addr || !mtt_count)
> +			goto done;
> +
> +		npage = min(mtt_count, left);
> +		memcpy(&mtts[total], addr, BA_BYTE_LEN * npage);
> +		left -= npage;
> +		total += npage;
> +	}
> +
> +done:
> +	if (base_addr)
> +		*base_addr = mtr->hem_list.root_ba;
> +
> +	return total;
> +}
> +EXPORT_SYMBOL_GPL(hns_roce_mtr_find);

Why is there an EXPROT_SYMBOL in a IB driver? I see many in
hns. Please send a patch to remove all of them and respin this.

Jason
