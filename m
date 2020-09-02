Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA06325A750
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBIEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIBIEn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 04:04:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070FC061245
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 01:04:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x14so4171144wrl.12
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ITan/zWSkbnHfpsc035XWViobYfAo1iIHcwyiV6vkj4=;
        b=Ei7BzzoxqD3QGipbXt1TuGH/beBPbo1RAf16/0vRAsw/iy+rXNLeISy72B+5AEtnpu
         zBNjabWW79SX5ZhUBPwQ8ykTA1sO4KEt17z8lhruVcHxlLYttBqZ/4jf33/tY30WShY1
         A/LAVnjntmc+pKn4HK0tMTtNxZN4MzL8g9bdWcqpUV18YSgZ47eGmFSRzMsQgDKVT6be
         ZMfGK5yozLBTj4+wbyfWou5pVSPWYuqvCIrZuWh3Pdoo0GRlCSezl3rmImcJsULSOdkI
         0SoWVrGywta4MUPG7ffDnHJ1xgrCWvZwFBnCVV0LfSHPuNXPkXtIDYgcnj6yTDS9Kqsb
         BnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ITan/zWSkbnHfpsc035XWViobYfAo1iIHcwyiV6vkj4=;
        b=pNar9WlcxdYA/illNKt+VFhwlk5Ojo2FJyCqtL+31o4iUochhJ0LLhn0JkBryWXh7Q
         UWDmcHqZx99pRchJGcJiVLh3YJPjQa9TZ4E+oBQSgA3OjoiJSiqQf8ZLqjE9Yhwbq3T5
         hG1710y1sj1TVny6WbK5QmugGq4okVDm15+uNkmHzaT3oHrMtwrmXfsjV4jGt+FdR2Dv
         pE9cn7l6GjOpaR8q/c/XQ2yuhE1uMihdBeAb5tVekUimmEByJoUoRhvH0iD+coG0it+E
         tlRc/8P3wfBDbJKmqvAl9i7kyrdSnZfBIlkiuSez83IajRPl/jtrPa4uDE+dgqRI6lio
         Hdag==
X-Gm-Message-State: AOAM5305NEvzBj55xa4Ezv/URHWwsnjLPATnlPiLtaSoXLBsul/FwGjA
        fUKW1mWhtGAK93kvS/Z/hie9LWTGLqG7J3yCMVz9IFR5g0xPyA4=
X-Google-Smtp-Source: ABdhPJwjmZyPbIbsIS0onIVB4/6WhNp5Hwjzy8zBBzVuPFznPgphMCKLBbkBEU9IhwXmGLh7hyv56e86QYxlsUzSGrg=
X-Received: by 2002:adf:de08:: with SMTP id b8mr5595440wrm.4.1599033881354;
 Wed, 02 Sep 2020 01:04:41 -0700 (PDT)
MIME-Version: 1.0
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 2 Sep 2020 10:04:30 +0200
Message-ID: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
Subject: [RFC] Reliable Multicast on top of RTRS
To:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi @,

RTRS allows for reliable transmission of sg lists between two hosts
over rdma. It is optimised for block io. One can implement a client
and a server module on top of RTRS which would allow for reliable
transmission to a group of hosts.

In the networking world this is called reliable multicast. I think one
can say that reliable multicast is an equivalent to what is called
"mirror" in the storage world. There is something called XoR network
coding which seems to be an equivalent of raid5. There is also Reed
Solomon network coding.

Having a reliable multicast with coding rdma-based transport layer
would allow for very flexible and scalable designs of distributed
replication solutions based on different in-kernel transport, block
and replication drivers.

What do you think?

Best,
Danil.
