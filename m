Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0AB14E6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 21:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfILTs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 15:48:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfILTs3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 15:48:29 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D493A3B77
        for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2019 19:48:28 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id x77so30137665qka.11
        for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2019 12:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=61QboYD3iiABgIPRf2HlMrlmk6MxhQbWl2zQmj6oeyI=;
        b=AWc+VUJzUUt4DNdwLi7OP2Lnj/nJgvfA7nnFGSj7enZO0vce6hozF5xOwBjvKVKTjn
         NNTZlb1AFMet8bGJfwS2fmSCme/P/tS8OH3O4hjCjUh0wBID47uWgPC+D7vcq28cZ4V8
         oPH9p8WIts20B+VApLH4lcaqQe0f5EwGQJkY5Qg9J+pwjzMog5zwUvP22iGL+Ie8zpp3
         KSDBR8/lle/mh1aSo8Qecaasoc/r6DsTnEXB6h67+H+Km7D/foSIBfQPdXYZEltW+aGh
         D+se/FO9c9R70aEkPRjuz572mLBjRe24QUlAgQhF3TxE8yXmlMBNur/TPY9IL3ZIeQO1
         q9yQ==
X-Gm-Message-State: APjAAAXu+z7O1diUuxpKf+9M4dUWjZ9fpqOW7lsSVo2fgvLr//p9FNYB
        klM0QE8ufBcNfIFZ6U5i2tBDvh7ChBpOimtauJXm2jPiNabgWV9OJolkGf0pToSbMIKbfLVT3t/
        ofh5Mca+FJ4PmQCxkICt8rQ==
X-Received: by 2002:a05:620a:14c:: with SMTP id e12mr42902880qkn.47.1568317708034;
        Thu, 12 Sep 2019 12:48:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvy4HlnPwFmMY7OGSLAwWPsnOk3wL2kdXtjjsTYZKViB362tSkOuwRX2TNDcPqMqQnbkNocg==
X-Received: by 2002:a05:620a:14c:: with SMTP id e12mr42902843qkn.47.1568317707637;
        Thu, 12 Sep 2019 12:48:27 -0700 (PDT)
Received: from dhcp-49-30.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m125sm12195474qkd.3.2019.09.12.12.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:48:27 -0700 (PDT)
Message-ID: <3d41038fc1e720937606589d1ba91591486dd548.camel@redhat.com>
Subject: 5.3-rc8 tests all pass with RDMA/SRP testing
From:   Laurence Oberman <loberman@redhat.com>
To:     "Van Assche, Bart" <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Dutile, Don" <ddutile@redhat.com>
Cc:     Rupesh Girase <rgirase@redhat.com>
Date:   Thu, 12 Sep 2019 15:48:25 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bart

My usual 3 month SRP test results show all is still well with SRP
client drivers and multipath.
I am still using 4.16 for the ib_srpt on the target server.

5.3-rc8 ib_srp CX4 100Gbit EDR tests
direct and unbuffered, large and small I/O sizes
port recovery with fault injection

One small observation was that after fault injection it seemed to take
longer to log back in, in that I needed to extend my sleep in the
injection script to avoid some multipaths lose all paths.

I was sleeping 30s between resets prior to this and I would log back in
quick enough to not lose all paths.
My sleep is now 60s

#on ibclient server in /sys/class/srp_remote_ports, using echo 1 >
delete for the particular port will simulate a port reset.

#/sys/class/srp_remote_ports
#[root@ibclient srp_remote_ports]# ls
#port-1:1  port-2:1
for d in /sys/class/srp_remote_ports/*
do
	echo 1 > $d/delete
sleep 60
done

Anyway, seem fine

Regards
Laurence Oberman

