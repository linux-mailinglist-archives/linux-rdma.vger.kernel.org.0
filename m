Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEA2B5B68
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKQI4Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 03:56:16 -0500
Received: from postmanrt1.riken.jp ([134.160.33.66]:60300 "EHLO
        postmanrt1.riken.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKQI4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 03:56:16 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 03:56:15 EST
Received: from postman-ex1.riken.jp (postman-ex1.riken.go.jp [134.160.33.91])
        by postmanrt1.riken.jp (Postfix) with ESMTP id 667701E0E82
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 17:46:23 +0900 (JST)
Received: from postman-ex1.riken.jp (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 1CCA8DC03DD;
        Tue, 17 Nov 2020 17:46:22 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 localhost 1CCA8DC03DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riken.jp; s=s1-2020;
        t=1605602782; bh=U6o+48LZxFzamhrcg8P9z8QmBQTJU5v9dzF4zFTlirM=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=WOioGUQFtQZVqgoQjd/3SWMwwUfAvnMX/thUzF7JNzGOat+96e7xiDHiSIseKmto3
         PNv8DcDRIJoV+YEKg5ytbW+iZlC8j1tWoDSwPkELZinQ+04IuY7DHODSjuxD0CDg+b
         lXN3wkI3OZ+a4uE4Nlprku7pz6L8hvHNe9F03EYzldqUrpOpGxGIVKFeqG0Hq2qNpY
         pIs+ln2qHU8Fr6SbbE8W7AxW7w32t3kGXW+cDQC7ii+U8CQQtOzExaW9HXRczQboYV
         fF678qB7zEQEdyFDpQveiBMHbGlNvouTTnmjvz4M4lY1XlKZ5C+xyWQyaohQGXretR
         4qtZYgSopwK4g==
Received: from postman.riken.jp (unknown [192.168.60.184])
        by postman-ex1.riken.jp (Postfix) with ESMTP id 129D8DC026A;
        Tue, 17 Nov 2020 17:46:22 +0900 (JST)
Received: from postman.riken.jp (localhost.localdomain [127.0.0.1])
        by postman.riken.jp (Postfix) with SMTP id E530B67E00A;
        Tue, 17 Nov 2020 17:46:21 +0900 (JST)
Received: from [192.168.11.9] (ab241072.dynamic.ppp.asahi-net.or.jp [183.76.241.72])
        by postman.riken.jp (Postfix) with ESMTPA id AE71F15003A;
        Tue, 17 Nov 2020 17:46:21 +0900 (JST)
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
To:     Christopher Lameter <cl@linux.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
Cc:     linux-rdma@vger.kernel.org
From:   Jens Domke <jens.domke@riken.jp>
Message-ID: <bbaa9827-fed4-492b-5c22-e543e8c69fbf@riken.jp>
Date:   Tue, 17 Nov 2020 17:46:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2020.11.17.84217, AntiVirus-Engine: 5.77.0, AntiVirus-Data: 2020.9.1.5770004
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2020.3.25.52717, AntiVirus-Engine: 5.72.0, AntiVirus-Data: 2020.3.25.5720000
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Christopher,

On 11/17/20 11:57 AM, Christopher Lameter wrote:
> We have a large number of apps running on the same host that are all
> sending to the same set of hosts. Lots of requests for address resolution
> are going to the SM and for a large set of hosts this can become too much
> for the SM.

I have used ibacm successfully years ago (think somewhere in the
2013-2015 timeframe) but abandoned the approach because some
measurements indicated that using OpenMPI with rdmacm had a big
runtime overhead compared to using OpenMPI+oob (Mellanox was
informed but I'm unsure how much has changed until now)

> Is there something that can locally cache the results of the SM queries to
> avoid additional requests?

Not that I know of, but others might know better. Maybe try contacting
Sean Hefty (driver behind ibacm) directly if he missed your email here
on the list.

> We have tried IBACM but the address resolution does not work on it. It is
> unable to complete a request for any address resolution and leaves kernel
> threads that never terminate instead.

Setting up ibacm was/is painful, maybe you could verify that it works on
a test bed with lowlevel rdmacm tools to debug with ping-pong, etc.

Furthermore, another thing I learned the hard way was that a cold cache
can overwhelm opensm as well. So, if you deploy ibacm, you have to make
sure that not too many requests go to the local ibacm on too many nodes
simultaneously right after starting ibacm service, otherwise having all
nodes sending numerous requests to opensm could timeout -> could be the
reason for your stalled kernel threads.

(another explanation is obviously a bug in ibacm and/or incompatibility
to newer versions of librdmacm or opensm or other IB libs)

Sorry, that I cannot provide more specific and direct help, but maybe my
pointers can help you solve the issue.

Best,
  Jens
