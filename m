Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2283548520A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 12:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiAELwM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 06:52:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52610 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiAELwL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 06:52:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 859786171E
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 11:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D1C36AE9;
        Wed,  5 Jan 2022 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641383531;
        bh=ytA2/NszCpUdmuRq64zEU9Oe2SZKZPUe4KgNI4WDXW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQMW72xAEzvU6qaz/5MqvsZVSRsQFr8y+XnhnlCYjhoktcDUF42QlKVgmFnngfSWC
         C5kZWNdoLuxUytvNXNONfNBP9NckzCovDvdEDRNOjIAsjAaX5qg3leu04WwdonESZl
         Axmb0xh/NHwQbbA0d7WKy3aLhPXFFHl0RUy8Cczt1eBZ0fBlAq/JdUre1n+R9iXWbf
         cbPyM23DcNWHWjjTWH51+zAbE429f+acAmeQ07ptRleljYu0vOADBhjRrkDSQMuBbC
         wZS7Ri56SGy5hxcjzp7zq0K9fxo6VvUL+mQ+veIdTuexQSBjyVu9xc8ifJ8JFq9bUv
         U+FIC2bIXScTQ==
Date:   Wed, 5 Jan 2022 13:52:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Benjamin Drung <benjamin.drung@ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: iblinkinfo for Python
Message-ID: <YdWGZggTD38xgMh6@unreal>
References: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 11:32:40AM +0100, Benjamin Drung wrote:
> Hi,
> 
> we have an in-house Shell script that uses iblinkinfo to check if the
> InfiniBand cabling is correct. This information can be derived from the
> node names that can be seen for the HCA port. I want to improve that
> check and rewrite it in Python, but I failed to find an easy and robust
> way to retrieve the node names for a HCA port:
> 
> 1) Call "iblinkinfo --line" and parse the output. Parsing the output
> could probably be done with a complex regular expression. This solution
> is too ugly IMO.
> 
> 2) Extend iblinkinfo to provide a JSON output. Then let the Python
> script call "iblinkinfo --json" and simply use json.load for parsing.
> This solution requires some C coding and probably a good json library
> should be used to avoid generating bogus JSON.
> 
> 3) Use https://github.com/jgunthorpe/python-rdma but this library has
> not been touched for five years and needs porting to Python 3. So that
> is probably a lot of work as well.
> 
> 4) Use pyverbs provided by rdma-core, but I found neither a single API
> call to query similar data to iblinkinfo, nor an example for that use
> case.
> 
> What should I do?

Isn't this information available in sysfs?
[leonro@mtl-leonro-l-vm ~]$ cat /sys/class/infiniband/ibp0s9/node_desc
mtl-leonro-l-vm ibp0s9

Can you give an example?

Thanks

> 
> -- 
> Benjamin Drung
> 
> Senior DevOps Engineer and Debian & Ubuntu Developer
> Compute Platform Operations Cloud
> 
> IONOS SE | Revaler Str. 30 | 10245 Berlin | Deutschland
> E-Mail: benjamin.drung@ionos.com | Web: www.ionos.de
> 
> Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498
> 
> Vorstand: Hüseyin Dogan, Dr. Martin Endreß, Claudia Frese, Henning
> Kettler, Arthur Mai, Britta Schmidt, Achim Weiß
> Aufsichtsratsvorsitzender: Markus Kadelke
> 
> 
> Member of United Internet
> 
