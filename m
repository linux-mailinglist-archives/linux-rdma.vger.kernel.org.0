Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8814DB8089
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbfISSC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 14:02:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45304 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389114AbfISSC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 14:02:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so5324987qtj.12
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AcjDEoyT8V9CYZ8n6Pxllk332IPdSLhpWcSbPXNehJQ=;
        b=FCSBB5Q+5lTnf49wKakA9Fuz37M05+YEqDSVAaR1dSQ32Fb4gJ660uVz0zP8bZzS3d
         soZ58XXEN+KQ1I8Y33ZySw+UCs96ejkvzLNOY91VJlClU2ZLqI7WIUaYdLztpEGuTvkK
         Y6g7R/vtc98vXmVME5QaW9JGFWwE/j9b2xJHEOSifvHFsBxqyfYiCzX/46p0QILYOhqA
         6roUbVIHLx4T+Hmd5ThK3ZQmXbi5TMbbqKvI1y8Fgu4v19PImj1uWVuzg6HlAtqVSHVU
         RUHrLvJbV0duAPdDhRUtX284efkJlCRvWBlsTMhHCUTscoOXXZ1J+r97P84Oe4AKTuJq
         XBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AcjDEoyT8V9CYZ8n6Pxllk332IPdSLhpWcSbPXNehJQ=;
        b=Fvbdw7AIIX4o8XC4tCIp0113WFVa+yk8cHWUidjhNSIKAt/D9vmmVW8qk5Z/0v6/oJ
         dCocTVP9bTKPgvkK9LqPSidKCPdLfowrh7luVmax77yIKw5nGMg1nfwqvtQInjALbKiO
         16D9BXzyJQw4lYT02VwRO9HQDSMH/hbk80PpCinDEpu3UM81k1duVilsGMcUQP2qzNnm
         P2dgC4+l0fsgoIBkvTWHEPJcugWnf6cpUgEOzAraK8RO8SiSgzSOl7WThPTavraDXnpg
         BIQlnFsNBiyOHzoHbYCeGdXxKyZmhKAaaJgkHO2qpQry2AEQ+v2EYeF7W78cDuNjsKFF
         9XTQ==
X-Gm-Message-State: APjAAAUz/R/ISSe87Gw3/PKoeR8I/E4zx549apGPzEsXpyaylPETv1F6
        b9tw4VPm0nHupnkJKthGhar0yg==
X-Google-Smtp-Source: APXvYqyEek94aPuhpq1Ytugzg/tYGo08nFvhBaTo6+MMKiZlZYEN3752fIHX+OXT2xHFNWf7mkpswg==
X-Received: by 2002:ac8:5554:: with SMTP id o20mr4615640qtr.282.1568916146267;
        Thu, 19 Sep 2019 11:02:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id g45sm5730412qtc.9.2019.09.19.11.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 11:02:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB0l7-0002ZF-0F; Thu, 19 Sep 2019 15:02:25 -0300
Date:   Thu, 19 Sep 2019 15:02:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
Message-ID: <20190919180224.GE4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-7-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:

> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
>  {
>  	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
>  
> +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
> +		free_page((unsigned long)phys_to_virt(entry->address));
> +

While it isn't wrong it do it this way, we don't need this mmap_free()
stuff for normal CPU pages. Those are refcounted and qedr can simply
call free_page() during the teardown of the uobject that is using the
this page. This is what other drivers already do.

I'm also not sure why qedr is using a phys_addr for a struct page
object, seems wrong.

Jason
