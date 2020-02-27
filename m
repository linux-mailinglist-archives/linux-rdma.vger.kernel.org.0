Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D491718C2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 14:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgB0Ndq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 08:33:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42810 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgB0Ndq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 08:33:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so2228364qtt.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 05:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/sQaUqNMneoAU0Jre+aQ8gmHYgYcC4sAf/3h4JVqHAg=;
        b=M7DWF5wp5XdHN7LcF/XZQh6mgsv98Hvi5OuvAwNMC/fJOGwsWamh29pKbcDYXQ/P8r
         N7CK3vBHglLWsAnYzRHC+I1FRXUSVCoJFP2Hpn+5ipRkOBKyczib/Z49OFNMBWdInGzE
         XIEJDgy/1DZF/w8vkdLZ37OsvUMG/zoTOrdQI4YJmb3KfR0+P2HkrrG38kXYkthsZXv/
         zy55JNj/RCCLg+0mI2ZyDN2uPx+IalzoSHVlifYxQVFm0svjkQnvnsHpCWkOoWLJws0g
         98JnpUiybh6KRyo/KM9AauaJM4Z60pd82JsY2YRDX2oiJx3sfbo3eurk2fqnrmnaecJt
         WX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sQaUqNMneoAU0Jre+aQ8gmHYgYcC4sAf/3h4JVqHAg=;
        b=VoUgBtbuKYJYkvdLVYAVLc8DcQriPS9v2UROIyxOoCQSYmP9+1urkLGf3fx5MH6jG9
         tl9a2N7aEMJP8HyinON5RHbdmBqVyrNCqIdZR/GN7dxk1oECmc1nYl2hBDwAmutg2jE5
         PwvFXuQCY/b2pmKITtXmkJ7ZcEifirzaM5p0g9v/O1/uHIsaESmpc+qrH7uT8c84ONjb
         z/y3IbISc6NTXxtA1mYagKLACr2lymAmKWI97Eq7lo/puxUB6WfvYrqsPlkv989IwfY7
         FXSovs9vnd6yavVuoomaD7fKk9wuKTpjpp9r+iH0G2eRE1mv4xZvgPrbLBk05316IGl3
         M9lw==
X-Gm-Message-State: APjAAAWXeE0ad286ZXgegute7+fdhpIbme88oVCgwv5HGl2cOyR/Kd8t
        +hLMV8c9YFBgjufI7lTnpFswWvvyBN6l4A==
X-Google-Smtp-Source: APXvYqzzxowZVY3acVlYz4+HdALd/ucjZ6MHvwH3wUpct1n59ueOU5hhGpxziT+LGeADqIVSXZuCFg==
X-Received: by 2002:ac8:538e:: with SMTP id x14mr5100073qtp.301.1582810423407;
        Thu, 27 Feb 2020 05:33:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g2sm3025364qka.42.2020.02.27.05.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 05:33:42 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7JIL-0003PD-Ui; Thu, 27 Feb 2020 09:33:41 -0400
Date:   Thu, 27 Feb 2020 09:33:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200227133341.GG31668@ziepe.ca>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca>
 <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
 <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 09:48:45AM +0200, Haim Boozaglo wrote:
> 
> 
> On 2/26/2020 7:09 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
> > > > On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> > > > > 
> > > > > 
> > > > > On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > > > > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > > > > Hi all,
> > > > > > > 
> > > > > > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > > > > > is displayed in an unsorted order.
> > > > > > > 
> > > > > > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > > > > > alphabetical order.
> > > > > > > 
> > > > > > > The problem is that users expect to have the output sorted in alphabetical
> > > > > > > order and now they get it not as expected (in an unsorted order).
> > > > > > 
> > > > > > Really? Why? That doesn't look like it should happen, the list is
> > > > > > constructed out of readdir() which should be sorted?
> > > > > > 
> > > > > > Do you know where this comes from?
> > > > > > 
> > > > > > Jason
> > > > > > 
> > > > > 
> > > > > readdir() gives us struct by struct and doesn't keep on alphabetical order.
> > > > > Before pull request #561 ibstat have used this API of libibumad:
> > > > > int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> > > > > 
> > > > > This API used this function:
> > > > > n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> > > > > 
> > > > > scandir() can return a sorted CA device list in alphabetical order.
> > > > 
> > > > Oh what a weird unintended side effect.
> > > > 
> > > > Resolving it would require adding a sorting pass on a linked
> > > > list.. Will you try?
> > > 
> > > Please be aware that once ibstat will be converted to netlink, the order
> > > will change again.
> > 
> > This is why I suggest a function to sort the linked list that tools
> > needing sorted order can call. Then it doesn't matter how we got the list
> > 
> > Jason
> > 
> 
> I can just sort the list at the time of insertion of each node.

I'd rather not have to pay the sorting penalty for all users, it seems
only a few command line tools need the sort

Jason
