Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36C016B064
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBXTld (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 14:41:33 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:43121 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXTld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 14:41:33 -0500
Received: by mail-qk1-f173.google.com with SMTP id p7so9739968qkh.10
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqdOYB7B35wJqjZS3dPw9S9ZCirG0WSbcj2KCUih6+M=;
        b=MvCW1R5yX9ZZCDO18u34LF1Uh3iQPRNZhDhjsLbaRIheFm2BSx8h7Tn5Vonk+4VaEa
         1yeVJEQDddZNE96+hnMmVw+aVG8Ip/KBk+ZeHQ6QEMNArccCpQqWxSA4eLLvLprwYG5J
         8zL/fIeAxMEnSoFUv71fl+we4Xivjd6sQs1EnOQ6vbVDJZJskl4AzQTerlAO1KTl7KcE
         KMcNenhT9p4Pqc+ehLqjueffh11crJ9umyy/0VJQRH2r62rY8txpuN0IUY0SMjpoJNYf
         v8d5e8g5ZwszPnnjBPlANfy+crrsn2NyWvpYu9t/NytT1juJcGm8LlZgrkqjjrhNCQdj
         RaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqdOYB7B35wJqjZS3dPw9S9ZCirG0WSbcj2KCUih6+M=;
        b=IAeA+7lmfsdd4oTR77UVzEHzKAF3+EcLXQx9gQExMNaKwnKqjLXGg807IaRSD/clZi
         JkJj0zb+ZVE7wZCpjSqpf2LeQiK/VtTyntzBcOiWzJ5tm0sWmvz0PVTHIjOipaCq0WVc
         o8wSjGaj/n2rrGsM9AUB44ObUvJEou1GXi7N0Tqqw11zKNi2dUFZli+BGBM2ALf+jugB
         6kbqXI6nYQqu0eE42y04BlQHNILWhrBpKeUCHPnHN3obGJtcileG1UsSD3cbU2zxX53v
         A/C5GwYDNrHnY20xR7UPEGzSd7EY/CoGRFLUt3oJbQwZnIYS+4tWRZh7P71O5P9zGqTl
         sV7A==
X-Gm-Message-State: APjAAAXZVkRkqE0E1m7GCy49rV4OVObQaJBUKK4NB9h3kqkLygqVJ1Qp
        HAsxH21zDbaUp/c1cdVN2nXBLw==
X-Google-Smtp-Source: APXvYqzpzIae/hQOBcFbQy1A61BE/hSCbCMWmYfzpLrp6Ock9jG4ZBUc2h4gHw4uFCHuPVmikTcPcg==
X-Received: by 2002:ae9:e202:: with SMTP id c2mr4746081qkc.224.1582573292445;
        Mon, 24 Feb 2020 11:41:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 184sm6214067qkm.133.2020.02.24.11.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 11:41:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6Jbf-00012L-9C; Mon, 24 Feb 2020 15:41:31 -0400
Date:   Mon, 24 Feb 2020 15:41:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200224194131.GV31668@ziepe.ca>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> Hi all,
> 
> When running "ibstat" or "ibstat -l", the output of CA device list
> is displayed in an unsorted order.
> 
> Before pull request #561, ibstat displayed the CA device list sorted in
> alphabetical order.
> 
> The problem is that users expect to have the output sorted in alphabetical
> order and now they get it not as expected (in an unsorted order).

Really? Why? That doesn't look like it should happen, the list is
constructed out of readdir() which should be sorted?

Do you know where this comes from?

Jason
