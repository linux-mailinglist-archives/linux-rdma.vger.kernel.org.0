Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5766F183767
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCLR1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 13:27:04 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:47103 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLR1D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 13:27:03 -0400
Received: by mail-qv1-f65.google.com with SMTP id m2so3008811qvu.13
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0D4uHAoTyKuSKkWwJQkQnpqRzgNDmqlKK/FwmHIQlfg=;
        b=V+mhRWsjKwrqR1equPrd66kersn+EMOExy7NpXlo1b+s+BosvQYYDsVJtuVYLzw1Jj
         QD9Dsp/3WziiKLoMMBtf7yiUOAcQVz31HvBQOE6J0qru/K2rQBxzU31usU+imj3vH9rt
         a/uot0f3WfABEWGCjTH44FvawsWWM23WFQCwocERlt620JmYdW5VRbuVuSc9fdRrcaru
         DLWoBtChXz22o3Wu03ApX4dDxCZ/dvzY8FhaRbL+cgZw5rsyXI43ZB7dJPuZnL99VOQY
         lOBzEPnUkeMIpRgQC+vctZh4U87QjXNVjNC6U9ST1q8BHkJVPmtyDxM2hkv5QlBcNA9C
         AwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0D4uHAoTyKuSKkWwJQkQnpqRzgNDmqlKK/FwmHIQlfg=;
        b=LOxwUYHTXVkKfgN5oexhlUG1PFGd7DpkWC/5EPfaXcazrQ2JPLIgVFTI1l9h+KWOm0
         paPP/m9jF46nRp6aq9Mrf+X/VpukUgLJQFlAiWeDUFcXjyeMFAl6iwWxkZYZM2E3+w5R
         7m0CrXvQ53F6awY8ulqB+KCrfNBBGGEtXdjM/2tAOmEi3SKhbP1Vm+IP0nkLsICrHnja
         aESAgEjDgPUJU+YgsLcpCzBColwPCCuCqHxJFAV6pSxk6tStSICOzWNYyKDIX1XlGtyQ
         IWr3E8GodaD+0/sK1BGnhv1nacNg681oqT8jhJthoXS8HnIgvz6pKyDvXpp7Om5p5yAG
         wgJA==
X-Gm-Message-State: ANhLgQ1gsAVuKKDZFbTLQhujSmwZwZYPd/ZZYVq2n1eEwdyt9iYnPVBm
        ZD3iNQhuFbOBuuLzixV0oudziw==
X-Google-Smtp-Source: ADFU+vs8AYzgPky6jnniZjqoX0CdIFKU1MD08EqgiQSsn3EIwq4DadN99QhWMpuFPF5o/I6DNpeQpQ==
X-Received: by 2002:ad4:4e73:: with SMTP id ec19mr8089472qvb.78.1584034022705;
        Thu, 12 Mar 2020 10:27:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 65sm27842005qtf.95.2020.03.12.10.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 10:27:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCRbp-00014P-RW; Thu, 12 Mar 2020 14:27:01 -0300
Date:   Thu, 12 Mar 2020 14:27:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200312172701.GV31668@ziepe.ca>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
>    What would you say to a per-process env variable to disable locking in
>    a userspace provider?

That is also a no. verbs now has 'thread domain' who's purpose is to
allow data plane locks to be skipped.

Generally new env vars in verbs are going to face opposition from
me.

Jason
